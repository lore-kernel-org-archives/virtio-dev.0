Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH 5/6] transport-mmio: Correct spelling errors
Date: Fri, 3 Feb 2023 22:16:19 +0200
Message-ID: <20230203201620.107744-6-parav@nvidia.com>
In-Reply-To: <20230203201620.107744-1-parav@nvidia.com>
References: <20230203201620.107744-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Now that we have individual files, fix reported spelling errors.

While at it, remove extra white space at end of line.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-mmio.tex | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/transport-mmio.tex b/transport-mmio.tex
index 7f2e0c3..7f4cc15 100644
--- a/transport-mmio.tex
+++ b/transport-mmio.tex
@@ -18,7 +18,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio=
 Transport Options / Vi
=20
 MMIO virtio devices provide a set of memory mapped control
 registers followed by a device-specific configuration space,
-described in the table~\ref{tab:Virtio Trasport Options / Virtio Over MMIO=
 / MMIO Device Register Layout}.
+described in the table~\ref{tab:Virtio Transport Options / Virtio Over MMI=
O / MMIO Device Register Layout}.
=20
 All register values are organized as Little Endian.
=20
@@ -32,7 +32,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio=
 Transport Options / Vi
=20
 \begin{longtable}{p{0.2\textwidth}p{0.7\textwidth}}
   \caption {MMIO Device Register Layout}
-  \label{tab:Virtio Trasport Options / Virtio Over MMIO / MMIO Device Regi=
ster Layout} \\
+  \label{tab:Virtio Transport Options / Virtio Over MMIO / MMIO Device Reg=
ister Layout} \\
   \hline
   \mmioreg{Name}{Function}{Offset from base}{Direction}{Description}=20
   \hline=20
@@ -272,13 +272,13 @@ \subsection{MMIO Device Register Layout}\label{sec:Vi=
rtio Transport Options / Vi
=20
 \drivernormative{\subsubsection}{MMIO Device Register Layout}{Virtio Trans=
port Options / Virtio Over MMIO / MMIO Device Register Layout}
 The driver MUST NOT access memory locations not described in the
-table \ref{tab:Virtio Trasport Options / Virtio Over MMIO / MMIO Device Re=
gister Layout}
+table \ref{tab:Virtio Transport Options / Virtio Over MMIO / MMIO Device R=
egister Layout}
 (or, in case of the configuration space, described in the device specifica=
tion),
 MUST NOT write to the read-only registers (direction R) and
 MUST NOT read from the write-only registers (direction W).
=20
 The driver MUST only use 32 bit wide and aligned reads and writes to acces=
s the control registers
-described in table \ref{tab:Virtio Trasport Options / Virtio Over MMIO / M=
MIO Device Register Layout}.
+described in table \ref{tab:Virtio Transport Options / Virtio Over MMIO / =
MMIO Device Register Layout}.
 For the device-specific configuration space, the driver MUST use 8 bit wid=
e accesses for
 8 bit wide fields, 16 bit wide and aligned accesses for 16 bit wide fields=
 and 32 bit wide and
 aligned accesses for 32 and 64 bit wide fields.
@@ -407,14 +407,14 @@ \subsection{Legacy interface}\label{sec:Virtio Transp=
ort Options / Virtio Over M
 in a slightly different control register layout, the device
 initialization and the virtual queue configuration procedure.
=20
-Table \ref{tab:Virtio Trasport Options / Virtio Over MMIO / MMIO Device Le=
gacy Register Layout}=20
+Table \ref{tab:Virtio Transport Options / Virtio Over MMIO / MMIO Device L=
egacy Register Layout}
 presents control registers layout, omitting
 descriptions of registers which did not change their function
 nor behaviour:
=20
 \begin{longtable}{p{0.2\textwidth}p{0.7\textwidth}}
   \caption {MMIO Device Legacy Register Layout}
-  \label{tab:Virtio Trasport Options / Virtio Over MMIO / MMIO Device Lega=
cy Register Layout} \\
+  \label{tab:Virtio Transport Options / Virtio Over MMIO / MMIO Device Leg=
acy Register Layout} \\
   \hline
   \mmioreg{Name}{Function}{Offset from base}{Direction}{Description}=20
   \hline=20
--=20
2.26.2

