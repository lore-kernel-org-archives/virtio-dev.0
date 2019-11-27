Return-Path: virtio-dev-return-6409-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4B858985ECE
	for <virtio-dev@lists.oasis-open.org>; Wed, 27 Nov 2019 10:21:20 +0000 (UTC)
Date: Wed, 27 Nov 2019 10:21:10 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20191127102110.GE3016@work-vm>
References: <20191122144824.483847-1-stefanha@redhat.com>
 <20191122144824.483847-2-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191122144824.483847-2-stefanha@redhat.com>
Subject: [virtio-dev] Re: [PATCH 1/2] virtio-fs: add file system device to Conformance
 chapter
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, mszeredi@redhat.com, vgoyal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> The file system device is not listed in the Conformance chapter.  Fix
> this.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  conformance.tex | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/conformance.tex b/conformance.tex
> index 0ac58aa..25d11ec 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -183,6 +183,16 @@ \section{Conformance Targets}\label{sec:Conformance =
/ Conformance Targets}
>  \item \ref{drivernormative:Device Types / Socket Device / Device Operati=
on / Device Events}
>  \end{itemize}
> =20
> +\conformance{\subsection}{File System Driver Conformance}\label{sec:Conf=
ormance / Driver Conformance / File System Driver Conformance}
> +
> +A file system driver MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{drivernormative:Device Types / File System Device / Device co=
nfiguration layout}
> +\item \ref{drivernormative:Device Types / File System Device / Device Op=
eration / Device Operation: High Priority Queue}
> +\item \ref{drivernormative:Device Types / File System Device / Device Op=
eration / Device Operation: DAX Window}
> +\end{itemize}
> +
>  \conformance{\section}{Device Conformance}\label{sec:Conformance / Devic=
e Conformance}
> =20
>  A device MUST conform to the following normative statements:
> @@ -338,6 +348,16 @@ \section{Conformance Targets}\label{sec:Conformance =
/ Conformance Targets}
>  \item \ref{devicenormative:Device Types / Socket Device / Device Operati=
on / Receive and Transmit}
>  \end{itemize}
> =20
> +\conformance{\subsection}{File System Device Conformance}\label{sec:Conf=
ormance / Device Conformance / File System Device Conformance}
> +
> +A file system device MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{devicenormative:Device Types / File System Device / Device co=
nfiguration layout}
> +\item \ref{devicenormative:Device Types / File System Device / Device Op=
eration / Device Operation: High Priority Queue}
> +\item \ref{devicenormative:Device Types / File System Device / Device Op=
eration / Device Operation: DAX Window}
> +\end{itemize}
> +
>  \conformance{\section}{Legacy Interface: Transitional Device and Transit=
ional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transit=
ional Device and Transitional Driver Conformance}
>  A conformant implementation MUST be either transitional or
>  non-transitional, see \ref{intro:Legacy

These look OK.

Do you then need to add these entries to the list of 'one of clauses' in
7.1 ?

Dave

> --=20
> 2.23.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

