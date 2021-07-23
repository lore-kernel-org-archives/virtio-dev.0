Return-Path: <svaddagi@qti.qualcomm.com>
From: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>
Subject: [PATCH v1] virtio-mmio: Specify wait needed in driver during reset
Date: Fri, 23 Jul 2021 14:55:44 +0000
Message-ID: <BY5PR02MB707313DCD9C7D356D79C8F07F9E59@BY5PR02MB7073.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR02MB707313DCD9C7D356D79C8F07F9E59BY5PR02MB7073namp_"
To: "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Trilok Soni <tsoni@quicinc.com>, Pratik Patel <pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--_000_BY5PR02MB707313DCD9C7D356D79C8F07F9E59BY5PR02MB7073namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Changes since v0:

Introduce a new feature bit, VIRTIO_F_MMIO_RESET_WAIT, which controls wheth=
er a driver polls
for reset completion or not.

=3D=3D=3D

Reset of a virtio-mmio device is accomplished by writing 0 to its Status re=
gister.
For devices that are emulated in software, writes to Status register are tr=
apped
and resumed only after the reset operation is complete. Thus a driver can b=
e
assured of reset completion as soon as its write completes.

That may not be the case for virtio-mmio devices implemented in hardware
directly. A write could complete before the reset operation inside device i=
s
completed. Introduce a new feature, VIRTIO_F_MMIO_RESET_WAIT, that such dev=
ices
will offer as means to indicate to driver that they need to poll for reset
completion, indicated by a read of Status register returning 0.

Signed-off-by: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>

diff --git a/content.tex b/content.tex
index 5c70a3c..1990a5c 100644
--- a/content.tex
+++ b/content.tex
@@ -1924,7 +1924,10 @@ \subsection{MMIO Device Register Layout}\label{sec:V=
irtio Transport Options / Vi
 do not represent events which took place MUST be zero.

 Upon reset, the device MUST clear all bits in \field{InterruptStatus} and =
ready bits in the
-\field{QueueReady} register for all queues in the device.
+\field{QueueReady} register for all queues in the device. The device MUST =
also offer
+VIRTIO_F_MMIO_RESET_WAIT if it requires driver to poll for reset completio=
n
+indicated by a read of \field{Status} returning 0. Such a device MUST also=
 fail to accept
+FEATURES_OK bit if driver does not negotiate VIRTIO_F_MMIO_RESET_WAIT.

 The device MUST change value returned in \field{ConfigGeneration} if there=
 is any risk of a
 driver seeing an inconsistent configuration state.
@@ -1944,6 +1947,10 @@ \subsection{MMIO Device Register Layout}\label{sec:V=
irtio Transport Options / Vi
 8 bit wide fields, 16 bit wide and aligned accesses for 16 bit wide fields=
 and 32 bit wide and
 aligned accesses for 32 and 64 bit wide fields.

+The driver MUST accept VIRTIO_F_MMIO_RESET_WAIT if offered by device. Duri=
ng
+reset of such a device that offers VIRTIO_F_MMIO_RESET_WAIT, driver MUST p=
oll for
+reset completion indicated by a read of \field{Status} returning 0.
+
 The driver MUST ignore a device with \field{MagicValue} which is not 0x747=
26976,
 although it MAY report an error.

@@ -6672,6 +6679,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved F=
eature Bits}
   transport specific.
   For more details about driver notifications over PCI see \ref{sec:Virtio=
 Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And =
Device Operation / Available Buffer Notifications}.

+  \item[VIRTIO_F_MMIO_RESET_WAIT(40)] This feature could be offered by a d=
evice
+  using MMIO transport and indicates that the driver needs to poll for res=
et
+  completion indicated by a read of \field{Status} returning 0.
+
 \end{description}

 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
@@ -6708,6 +6719,8 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Fe=
ature Bits}

 A driver SHOULD accept VIRTIO_F_NOTIF_CONFIG_DATA if it is offered.

+A driver SHOULD accept VIRTIO_F_MMIO_RESET_WAIT if it is offered.
+
 \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}

 A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate furt=
her


---

Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a
non-member to the virtio-dev mailing list for consideration and inclusion.

--_000_BY5PR02MB707313DCD9C7D356D79C8F07F9E59BY5PR02MB7073namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Changes since v0:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Introduce a new feature bit, VIRTIO_F_MMIO_RESET_WAIT, which controls wheth=
er a driver polls</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
for reset completion or not.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
=3D=3D=3D</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reset of a virtio-mmio device is accomplished by writing 0 to its Status re=
gister.
<div>For devices that are emulated in software, writes to Status register a=
re trapped</div>
<div>and resumed only after the reset operation is complete. Thus a driver =
can be</div>
<div>assured of reset completion as soon as its write completes.</div>
<div>&nbsp; &nbsp; </div>
<div>That may not be the case for virtio-mmio devices implemented in hardwa=
re</div>
<div>directly. A write could complete before the reset operation inside dev=
ice is</div>
<div>completed. Introduce a new feature, VIRTIO_F_MMIO_RESET_WAIT, that suc=
h devices</div>
<div>will offer as means to indicate to driver that they need to poll for r=
eset</div>
<div>completion, indicated by a read of Status register returning 0.</div>
<div>&nbsp; &nbsp; </div>
<div>Signed-off-by: Srivatsa Vaddagiri &lt;svaddagi@qti.qualcomm.com&gt;</d=
iv>
<div><br>
</div>
<div>diff --git a/content.tex b/content.tex</div>
<div>index 5c70a3c..1990a5c 100644</div>
<div>--- a/content.tex</div>
<div>+++ b/content.tex</div>
<div>@@ -1924,7 +1924,10 @@ \subsection{MMIO Device Register Layout}\label{=
sec:Virtio Transport Options / Vi</div>
<div>&nbsp;do not represent events which took place MUST be zero.</div>
<div>&nbsp;</div>
<div>&nbsp;Upon reset, the device MUST clear all bits in \field{InterruptSt=
atus} and ready bits in the</div>
<div>-\field{QueueReady} register for all queues in the device.</div>
<div>+\field{QueueReady} register for all queues in the device. The device =
MUST also offer</div>
<div>+VIRTIO_F_MMIO_RESET_WAIT if it requires driver to poll for reset comp=
letion</div>
<div>+indicated by a read of \field{Status} returning 0. Such a device MUST=
 also fail to accept</div>
<div>+FEATURES_OK bit if driver does not negotiate VIRTIO_F_MMIO_RESET_WAIT=
.</div>
<div>&nbsp;</div>
<div>&nbsp;The device MUST change value returned in \field{ConfigGeneration=
} if there is any risk of a</div>
<div>&nbsp;driver seeing an inconsistent configuration state.</div>
<div>@@ -1944,6 +1947,10 @@ \subsection{MMIO Device Register Layout}\label{=
sec:Virtio Transport Options / Vi</div>
<div>&nbsp;8 bit wide fields, 16 bit wide and aligned accesses for 16 bit w=
ide fields and 32 bit wide and</div>
<div>&nbsp;aligned accesses for 32 and 64 bit wide fields.</div>
<div>&nbsp;</div>
<div>+The driver MUST accept VIRTIO_F_MMIO_RESET_WAIT if offered by device.=
 During</div>
<div>+reset of such a device that offers VIRTIO_F_MMIO_RESET_WAIT, driver M=
UST poll for</div>
<div>+reset completion indicated by a read of \field{Status} returning 0.</=
div>
<div>+</div>
<div>&nbsp;The driver MUST ignore a device with \field{MagicValue} which is=
 not 0x74726976,</div>
<div>&nbsp;although it MAY report an error.</div>
<div>&nbsp;</div>
<div>@@ -6672,6 +6679,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reser=
ved Feature Bits}</div>
<div>&nbsp; &nbsp;transport specific.</div>
<div>&nbsp; &nbsp;For more details about driver notifications over PCI see =
\ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Init=
ialization And Device Operation / Available Buffer Notifications}.</div>
<div>&nbsp;</div>
<div>+ &nbsp;\item[VIRTIO_F_MMIO_RESET_WAIT(40)] This feature could be offe=
red by a device</div>
<div>+ &nbsp;using MMIO transport and indicates that the driver needs to po=
ll for reset</div>
<div>+ &nbsp;completion indicated by a read of \field{Status} returning 0.<=
/div>
<div>+</div>
<div>&nbsp;\end{description}</div>
<div>&nbsp;</div>
<div>&nbsp;\drivernormative{\section}{Reserved Feature Bits}{Reserved Featu=
re Bits}</div>
<div>@@ -6708,6 +6719,8 @@ \chapter{Reserved Feature Bits}\label{sec:Reserv=
ed Feature Bits}</div>
<div>&nbsp;</div>
<div>&nbsp;A driver SHOULD accept VIRTIO_F_NOTIF_CONFIG_DATA if it is offer=
ed.</div>
<div>&nbsp;</div>
<div>+A driver SHOULD accept VIRTIO_F_MMIO_RESET_WAIT if it is offered.</di=
v>
<div>+</div>
<div>&nbsp;\devicenormative{\section}{Reserved Feature Bits}{Reserved Featu=
re Bits}</div>
<div>&nbsp;</div>
<div>&nbsp;A device MUST offer VIRTIO_F_VERSION_1. &nbsp;A device MAY fail =
to operate further</div>
<div><br>
</div>
<div><br>
</div>
<div>---</div>
<div><br>
</div>
<div>Qualcomm Innovation Center, Inc. is submitting the attached &quot;feed=
back&quot; as a</div>
<span>non-member to the virtio-dev mailing list for consideration and inclu=
sion.</span><br>
</div>
</body>
</html>

--_000_BY5PR02MB707313DCD9C7D356D79C8F07F9E59BY5PR02MB7073namp_--

