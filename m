Return-Path: virtio-dev-return-3986-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 46B385818DDE
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Apr 2018 08:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAEuE-LgihoR4EY9Crhwym0+dduSqh48sZf5r3bg-YukW91os2w@mail.gmail.com>
 <20180427101642.GD6999@stefanha-x1.localdomain>
In-Reply-To: <20180427101642.GD6999@stefanha-x1.localdomain>
From: Nirmalanand J <nirmalanand.jebakumar@gmail.com>
Date: Fri, 27 Apr 2018 15:25:28 +0000
Message-ID: <CAEuE-Lj87xvVZNEK3V2RmPo2g10PTsK2PgQHiZ6Ba=+kzXqFjA@mail.gmail.com>
Content-Type: multipart/alternative; boundary="001a113c9082d4953f056ad61ddc"
Subject: Re: [virtio-dev] Handling large VIRTIO_PCI_QUEUE_NUM values on Google
 Cloud Platform (GCP)
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--001a113c9082d4953f056ad61ddc
Content-Type: text/plain; charset="UTF-8"

Thanks Stefan. Appreciate your detailed response.

Regards,
Nirmal

On Fri, 27 Apr 2018, 5:52 pm Stefan Hajnoczi, <stefanha@redhat.com> wrote:

> On Wed, Apr 25, 2018 at 04:04:37PM +0530, Nirmalanand J wrote:
> > 1) The number of descriptor count returned by the back-end through
> > VIRTIO_PCI_QUEUE_NUM, is that negotiable with the backend? In some
> > platforms like Google Cloud Platform (GCP) the value returned is 4096.
>
> VIRTIO_PCI_QUEUE_NUM is the legacy VIRTIO PCI hardware register
> (called "queue_size" in 4.1.4.8 Legacy Interfaces: A Note on PCI Device
> Layout).  This field is read-only.
>
> However, in VIRTIO 1.0 the modern VIRTIO PCI queue_size field (4.1.4.3
> Common configuration structure layout) is writable during device
> initialization.  The driver may *reduce* the queue size.
>
> If you would like to use 256 descriptors instead of 4096, please make
> sure your driver uses VIRTIO 1.0 (VIRTIO_F_VERSION_1) and not the legacy
> interface.  Then the driver can reduce the number of descriptors to 256.
>
> If the device does not support VIRTIO_F_VERSION_1 then you are out of
> luck.
>
> Stefan
>

--001a113c9082d4953f056ad61ddc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks Stefan. Appreciate your detailed response.<div dir=
=3D"auto"><br></div><div dir=3D"auto">Regards,</div><div dir=3D"auto">Nirma=
l</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, 27 Apr=
 2018, 5:52 pm Stefan Hajnoczi, &lt;<a href=3D"mailto:stefanha@redhat.com">=
stefanha@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
On Wed, Apr 25, 2018 at 04:04:37PM +0530, Nirmalanand J wrote:<br>
&gt; 1) The number of descriptor count returned by the back-end through<br>
&gt; VIRTIO_PCI_QUEUE_NUM, is that negotiable with the backend? In some<br>
&gt; platforms like Google Cloud Platform (GCP) the value returned is 4096.=
<br>
<br>
VIRTIO_PCI_QUEUE_NUM is the legacy VIRTIO PCI hardware register<br>
(called &quot;queue_size&quot; in 4.1.4.8 Legacy Interfaces: A Note on PCI =
Device<br>
Layout).=C2=A0 This field is read-only.<br>
<br>
However, in VIRTIO 1.0 the modern VIRTIO PCI queue_size field (4.1.4.3<br>
Common configuration structure layout) is writable during device<br>
initialization.=C2=A0 The driver may *reduce* the queue size.<br>
<br>
If you would like to use 256 descriptors instead of 4096, please make<br>
sure your driver uses VIRTIO 1.0 (VIRTIO_F_VERSION_1) and not the legacy<br=
>
interface.=C2=A0 Then the driver can reduce the number of descriptors to 25=
6.<br>
<br>
If the device does not support VIRTIO_F_VERSION_1 then you are out of<br>
luck.<br>
<br>
Stefan<br>
</blockquote></div>

--001a113c9082d4953f056ad61ddc--
