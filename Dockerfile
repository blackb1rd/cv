# Builds the CV PDF with TeX Live, with nothing to install locally.
#
#   orb start
#   docker --context orbstack build --output build .
#
# writes build/Prachya-Saechua-CV.pdf. Add --pull to fetch the newest TeX Live image first.
# CI runs plain `docker build`, since GitHub's Linux runners have Docker built in.

# Full TeX Live, the same image the GitHub Actions workflows use
FROM texlive/texlive:latest AS build
WORKDIR /cv
COPY awesome-cv.cls resume.tex ./
COPY fonts/ fonts/
COPY sections/ sections/
# latexmk reruns XeLaTeX until cross-references and PDF bookmarks settle.
# -jobname names the PDF after its owner, since recruiters collect many resume.pdf files
RUN latexmk -xelatex -interaction=nonstopmode -halt-on-error -outdir=build \
      -jobname=Prachya-Saechua-CV resume.tex

# Export stage: holds only the PDF, so --output writes just that file
FROM scratch
COPY --from=build /cv/build/Prachya-Saechua-CV.pdf /
