Return-Path: virtio-dev-return-3952-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C856B1CB80F3
	for <virtio-dev@lists.oasis-open.org>; Wed, 25 Apr 2018 03:34:48 -0700 (PDT)
MIME-Version: 1.0
From: Nirmalanand J <nirmalanand.jebakumar@gmail.com>
Date: Wed, 25 Apr 2018 16:04:37 +0530
Message-ID: <CAEuE-LgihoR4EY9Crhwym0+dduSqh48sZf5r3bg-YukW91os2w@mail.gmail.com>
Content-Type: multipart/alternative; boundary="001a113d77ea573a57056aa9d1ed"
Subject: [virtio-dev] Handling large VIRTIO_PCI_QUEUE_NUM values on Google Cloud Platform (GCP)
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--001a113d77ea573a57056aa9d1ed
Content-Type: text/plain; charset="UTF-8"

Hello experts,

Have a query on the following:

1) The number of descriptor count returned by the back-end through
VIRTIO_PCI_QUEUE_NUM, is that negotiable with the backend? In some
platforms like Google Cloud Platform (GCP) the value returned is 4096.

2) In case it is not negotiable with the back-end and unable to allocate
data buffers on the Rx side for 4096 descriptors, is there a workaround to
manage with fewer buffers like 256?

Additional info:
This is a FreeBSD VM running on GCP.

Please let me know.

Regards,
Nirmal

--001a113d77ea573a57056aa9d1ed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello experts,<div><br></div><div>Have a query on the foll=
owing:</div><div><br></div><div>1) The number of descriptor count returned =
by the back-end through VIRTIO_PCI_QUEUE_NUM, is that negotiable with the b=
ackend? In some platforms like Google Cloud Platform (GCP) the value return=
ed is 4096.</div><div><br></div><div>2) In case it is not negotiable with t=
he back-end and unable to allocate data buffers on the Rx side for 4096 des=
criptors, is there a workaround to manage with fewer buffers like 256?</div=
><div><br></div><div>Additional info:</div><div>This is a FreeBSD VM runnin=
g on GCP.</div><div><br></div><div>Please let me know.=C2=A0</div><div><br>=
</div><div>Regards,</div><div>Nirmal</div></div>

--001a113d77ea573a57056aa9d1ed--
