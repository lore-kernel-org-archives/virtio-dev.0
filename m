Return-Path: virtio-dev-return-7793-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5BBB0986010
	for <virtio-dev@lists.oasis-open.org>; Thu, 17 Sep 2020 17:03:39 +0000 (UTC)
References: <20200824143708.5664-1-ndragazis@arrikto.com>
 <20200824143708.5664-6-ndragazis@arrikto.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20200824143708.5664-6-ndragazis@arrikto.com>
Date: Thu, 17 Sep 2020 18:01:51 +0100
Message-ID: <878sd8xrpc.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH 05/11] doorbells: Introduce doorbells
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


Nikos Dragazis <ndragazis@arrikto.com> writes:

> Introduce doorbells as a new virtio device resource.
>
> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
> ---
>  content.tex   |  2 ++
>  doorbells.tex | 12 ++++++++++++
>  2 files changed, 14 insertions(+)
>  create mode 100644 doorbells.tex
>
> diff --git a/content.tex b/content.tex
> index 94a3693..38ed709 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -373,6 +373,8 @@ \section{Driver Notifications} \label{sec:Virtqueues =
/ Driver notifications}
> =20
>  \input{shared-mem.tex}
> =20
> +\input{doorbells.tex}
> +
>  \chapter{General Initialization And Device Operation}\label{sec:General =
Initialization And Device Operation}
> =20
>  We start with an overview of device initialization, then expand on the
> diff --git a/doorbells.tex b/doorbells.tex
> new file mode 100644
> index 0000000..e917536
> --- /dev/null
> +++ b/doorbells.tex
> @@ -0,0 +1,12 @@
> +\section{Doorbells}\label{sec:Basic Facilities of a Virtio device / Door=
bells}
> +
> +A doorbell is a device register that triggers a notification to the
> +device when accessed by the driver.
> +
> +Doorbells are an additional facility available to devices that need to
> +support receiving driver notifications for events other than virtqueue
> +activity (i.e., notifications that are device-specific).
> +
> +A device may be exporting multiple doorbells to the driver.
> +
> +The location of doorbells is found in a transport-specific way.

I just realised we don't specify anything about delivery. Should we say
something about lack of acknowledgement or guarantee that the
notification is delivered here?=20

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

