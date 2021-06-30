Return-Path: <virtio-dev-return-8208-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Date: Wed, 30 Jun 2021 13:58:51 +0200
Message-Id: <20210630115851.12272-2-info@metux.net>
In-Reply-To: <20210630115851.12272-1-info@metux.net>
References: <20210630115851.12272-1-info@metux.net>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 2/2] add .gitignore
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Prevent accidentially adding auto generated files to the repo.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 .gitignore | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 .gitignore

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..43e454a
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,19 @@
+/listings/virtio_queue.h
+/missfont.log
+/setup-generated.tex
+/tmpfilesforzip
+/virtio-*.4ct
+/virtio-*.4tc
+/virtio-*.aux
+/virtio-*.css
+/virtio-*.dvi
+/virtio-*.html
+/virtio-*.idv
+/virtio-*.lg
+/virtio-*.log
+/virtio-*.out
+/virtio-*.pdf
+/virtio-*.tex
+/virtio-*.toc
+/virtio-*.xref
+/virtio-*.zip
--=20
2.20.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

