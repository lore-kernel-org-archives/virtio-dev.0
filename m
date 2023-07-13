Return-Path: <virtio-dev-return-13373-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26100C001DC
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 09:16:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 96C157C6C9
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 09:16:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8DDB49867D4
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 09:16:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 811349867C1; Thu, 13 Jul 2023 09:16:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6F3D59867C7
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Jul 2023 09:16:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: vztW3oXbMRSex6j-bV90fw-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org,
 mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, hengqi@linux.alibaba.com,
 shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230712222405.455201-3-parav@nvidia.com>
Organization: Red Hat GmbH
References: <20230712222405.455201-1-parav@nvidia.com>
 <20230712222405.455201-3-parav@nvidia.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Thu, 13 Jul 2023 11:16:06 +0200
Message-ID: <87ttu8qii1.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH 2/4] virtio-net: Avoid hyphen and extra braces

On Thu, Jul 13 2023, Parav Pandit <parav@nvidia.com> wrote:

> Avoid hyphen and replace it with white space like rest of the entries.
> Also avoid unnecessary braces.
> Name RFC as just RFC without special prefix about it.
>
> This likely resolves the html generation errors.
>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  device-types/net/description.tex |  2 +-
>  introduction.tex                 | 15 +++++++--------
>  2 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index 6fd4a20..53c811f 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -904,7 +904,7 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>  \end{itemize}
>  
>  The per-packet hash calculation can depend on the IP packet type. See
> -\hyperref[intro:IP]{[IP]}, \hyperref[intro:UDP]{[UDP]} and \hyperref[intro:TCP]{[TCP]}.
> +\hyperref[intro:IP]{IP}, \hyperref[intro:UDP]{UDP} and \hyperref[intro:TCP]{TCP}.

I'd keep that as-is (I think it looks nicer with the brackets).

>  
>  \subparagraph{Supported/enabled hash types}
>  \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}
> diff --git a/introduction.tex b/introduction.tex
> index 81f07a4..028ec17 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -101,26 +101,25 @@ \section{Normative References}\label{sec:Normative References}
>  	\phantomsection\label{intro:SEC1}\textbf{[SEC1]} &
>      Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic Cureve Cryptography'', Version 1.0, September 2000.
>  	\newline\url{https://www.secg.org/sec1-v2.pdf}\\
> -
> -	\phantomsection\label{intro:gre_rfc2784}\textbf{[GRE_rfc2784]} &
> +	\phantomsection\label{intro:rfc2784}\textbf{[RFC2784]} &
>      Generic Routing Encapsulation. This protocol is only specified for IPv4 and used as either the payload or delivery protocol.
>  	\newline\url{https://datatracker.ietf.org/doc/rfc2784/}\\
> -	\phantomsection\label{intro:gre_rfc2890}\textbf{[GRE_rfc2890]} &
> -    Key and Sequence Number Extensions to GRE \ref{intro:gre_rfc2784}. This protocol describes extensions by which two fields, Key and
> -    Sequence Number, can be optionally carried in the GRE Header \ref{intro:gre_rfc2784}.
> +	\phantomsection\label{intro:rfc2890}\textbf{[RFC2890]} &
> +    Key and Sequence Number Extensions to GRE \ref{intro:rfc2784}. This protocol describes extensions by which two fields, Key and
> +    Sequence Number, can be optionally carried in the GRE Header \ref{intro:rfc2784}.
>  	\newline\url{https://www.rfc-editor.org/rfc/rfc2890}\\
> -	\phantomsection\label{intro:gre_rfc7676}\textbf{[GRE_rfc7676]} &
> +	\phantomsection\label{intro:rfc7676}\textbf{[RFC7676]} &
>      IPv6 Support for Generic Routing Encapsulation (GRE). This protocol is specified for IPv6 and used as either the payload or
>      delivery protocol. Note that this does not change the GRE header format or any behaviors specified by RFC 2784 or RFC 2890.
>  	\newline\url{https://datatracker.ietf.org/doc/rfc7676/}\\
> -	\phantomsection\label{intro:gre_in_udp_rfc8086}\textbf{[GRE-in-UDP]} &
> +	\phantomsection\label{intro:rfc8086}\textbf{[GRE in UDP]} &

Hyphens are ok, I'd keep it.

>      GRE-in-UDP Encapsulation. This specifies a method of encapsulating network protocol packets within GRE and UDP headers.
>      This protocol is specified for IPv4 and IPv6, and used as either the payload or delivery protocol.
>  	\newline\url{https://www.rfc-editor.org/rfc/rfc8086}\\
>  	\phantomsection\label{intro:vxlan}\textbf{[VXLAN]} &
>      Virtual eXtensible Local Area Network.
>  	\newline\url{https://datatracker.ietf.org/doc/rfc7348/}\\
> -	\phantomsection\label{intro:vxlan-gpe}\textbf{[VXLAN-GPE]} &
> +	\phantomsection\label{intro:vxlan gpe}\textbf{[VXLAN GPE]} &
>      Generic Protocol Extension for VXLAN. This protocol describes extending Virtual eXtensible Local Area Network (VXLAN) via changes to the VXLAN header.
>  	\newline\url{https://www.ietf.org/archive/id/draft-ietf-nvo3-vxlan-gpe-12.txt}\\
>  	\phantomsection\label{intro:geneve}\textbf{[GENEVE]} &


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

