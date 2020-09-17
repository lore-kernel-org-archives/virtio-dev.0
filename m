Return-Path: virtio-dev-return-7790-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 48B00986010
	for <virtio-dev@lists.oasis-open.org>; Thu, 17 Sep 2020 16:34:10 +0000 (UTC)
References: <20200824143708.5664-1-ndragazis@arrikto.com>
 <20200824143708.5664-4-ndragazis@arrikto.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20200824143708.5664-4-ndragazis@arrikto.com>
Date: Thu, 17 Sep 2020 17:34:05 +0100
Message-ID: <87k0wsxszm.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH 03/11] content: Update list of virtio cfg structures
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


Nikos Dragazis <ndragazis@arrikto.com> writes:

> Shared memory and vendor-specific configuration structures have been
> introduced in previous commits.
>
> Update the list of virtio configuration structures so that it includes
> the shared memory and vendor-specific configuration structures.
>
> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index 3ce768c..b5b2f79 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -634,6 +634,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{=
sec:Virtio Transport Option
>  \item ISR Status
>  \item Device-specific configuration (optional)
>  \item PCI configuration access
> +\item Shared memory regions (optional)
> +\item Vendor-specific data (optional)

Are we talking about "Vendor data capability" here? Maybe we should call
it that?

>  \end{itemize}
> =20
>  Each structure can be mapped by a Base Address register (BAR) belonging =
to


--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

