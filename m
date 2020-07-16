Return-Path: virtio-dev-return-7576-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 53AF5986080
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Jul 2020 16:48:28 +0000 (UTC)
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-3-ndragazis@arrikto.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20200518203721.7625-3-ndragazis@arrikto.com>
Date: Thu, 16 Jul 2020 17:48:24 +0100
Message-ID: <87sgdrv21z.fsf@linaro.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v5 02/10] vhost-user: minor fixes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


Nikos Dragazis <ndragazis@arrikto.com> writes:

> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  virtio-vhost-user.tex | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
> index ac96dc2..13ecd41 100644
> --- a/virtio-vhost-user.tex
> +++ b/virtio-vhost-user.tex
> @@ -231,7 +231,7 @@ \subsubsection{Doorbell structure layout}\label{sec:D=
evice Types / Vhost-user De
>  \end{lstlisting}
> =20
>  The \field{cap.offset} and \field{doorbell_off_multiplier} are taken fro=
m the
> -notification capability structure above, and the \field{doorbell_idx} is=
 the
> +doorbell capability structure above, and the \field{doorbell_idx} is the
>  doorbell number.

I think it would be helpful to add what we mean by doorbell and
notification into the terminology section at the front of the document?

> =20
>  \devicenormative{\paragraph}{Doorbell capability}{Device Types / Vhost-u=
ser Device Backend / Additional Device Resources over PCI / Doorbell capabi=
lity}
> @@ -260,7 +260,7 @@ \subsubsection{Notification structure layout}\label{s=
ec:Device Types / Vhost-use
>  notification interrupts.  If MSI-X is not available, bit 2 of the ISR st=
atus
>  indicates that a notification occurred.
> =20
> -The notification structure is found using the VIRTIO_PCI_CAP_DOORBELL_CF=
G
> +The notification structure is found using the VIRTIO_PCI_CAP_NOTIFICATIO=
N_CFG
>  capability.
> =20
>  \begin{lstlisting}


--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

