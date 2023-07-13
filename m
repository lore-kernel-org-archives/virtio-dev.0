Return-Path: <virtio-dev-return-13377-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C367C001DC
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 11:33:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9DB7469F67
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 11:33:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8D3159867C7
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 11:33:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7CB439867C2; Thu, 13 Jul 2023 11:33:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 65A569867C4
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Jul 2023 11:33:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: EYLbszGjN66Bt1Kp6ZZDXA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689247993; x=1691839993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4o7W5XfE1fX/9Y5YVG3d8tBADJLY7NbuibAanP9jYsY=;
        b=fAqplbHnqnbqS5VVULt+ptcnx6Mj8gKOwIucokp8YlLvIQAlwdMZYzB88C3ewWlLI9
         ZPAujDSY2UiU/5mrBnbcDki0WfTMN17J2RFdkSX65RzxeAhI3Z3kjgFic/2Eo9mMcrTa
         bCaVmJbARNVA9N1i9IenTGh9kPDnRFobq6/s1iktbV+JFKumQ5fHMV+n4WSnBycD3DOf
         tkHTPE/TTn9Xo+oKFo/+D2XUqM2TcfvKHcrlaRKHTQyymM4UDsQWg4vNX69D/IV0a1wi
         nDqueKP4adMxfilgtyl+jbpx2LPm0JppwRbkbZT3MyuWMiQxTDDGm9QqeZ4i7Edrc6SO
         OKhA==
X-Gm-Message-State: ABy/qLbtFrM1R593mzbsA/bjlY6WQgJtTVRQt2SmQKuezLKeaeI7vJ6y
	iwUyVgJqG4anuKdCG7BsKA+Q1Xxo1Do04sQUPAzW3eUaGbgR/+7xDN6KRo1/ODkHCFuezDJYqxJ
	zRPpeeMLKR1LIGdXc9CL7YgJFAv/8t+KZO3I9
X-Received: by 2002:a5d:5508:0:b0:30f:bb83:e6f4 with SMTP id b8-20020a5d5508000000b0030fbb83e6f4mr1319242wrv.0.1689247993437;
        Thu, 13 Jul 2023 04:33:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHCW4jmn6i76AExIbJbUbepDRKkySp/kjKw39A71vHKgXSRd6JwER2y6jeg004j1ZfeISzV3w==
X-Received: by 2002:a5d:5508:0:b0:30f:bb83:e6f4 with SMTP id b8-20020a5d5508000000b0030fbb83e6f4mr1319223wrv.0.1689247993062;
        Thu, 13 Jul 2023 04:33:13 -0700 (PDT)
Date: Thu, 13 Jul 2023 07:33:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, hengqi@linux.alibaba.com,
	shahafs@nvidia.com
Message-ID: <20230713073051-mutt-send-email-mst@kernel.org>
References: <20230712222405.455201-1-parav@nvidia.com>
 <87zg40qioi.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87zg40qioi.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 0/4] Short document fixes to inner hash feature

On Thu, Jul 13, 2023 at 11:12:13AM +0200, Cornelia Huck wrote:
> On Thu, Jul 13 2023, Parav Pandit <parav@nvidia.com> wrote:
> 
> > This short patches fixes the editing errors that stops the pdf and html
> > generation.
> >
> > These 3 fixes are for the patch [1] for the github issue [2].
> >
> > [1] https://lists.oasis-open.org/archives/virtio-comment/202307/msg00024.html
> > [2] https://github.com/oasis-tcs/virtio-spec/issues/173
> >
> > Patch summary:
> > patch-1 place C code under listing
> > patch-2 avoid hyphen and extra braces
> > patch-3 use table as hyperlink do not work well in C code listing
> > patch-4 refer 'advice' as 'note'
> >
> > Patch 1 to 3 appears to be must in the testing.
> > Patch 4 is not a fix and can be done later if it requires discussion.
> >
> > Parav Pandit (4):
> >   virtio-net: Place C code under listing
> >   virtio-net: Avoid hyphen and extra braces
> >   virtio-net: Use table to describe inner hash to rfc mapping
> >   virtio-net: Use note instead of advice
> >
> >  device-types/net/description.tex | 45 ++++++++++++++++++++++----------
> >  introduction.tex                 | 15 +++++------
> >  2 files changed, 38 insertions(+), 22 deletions(-)
> >
> 
> FTR, this is the diff I have locally (I had missed one underscore in the
> references yesterday...); maybe we can make the intra-reference links in
> introdcution.tex a bit nicer, but otherwise, this should be the minimal
> change to make this build:

Perfect. Seems like clearly an editorial fix.

Heng Qi, in the future I'd like to ask you to please build the
spec and review the resulting PDF and HTML, before posting.



> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index 206020de567d..76585b0dd6d3 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -1024,12 +1024,14 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>  If VIRTIO_NET_F_HASH_TUNNEL has been negotiated, the driver can send the command
>  VIRTIO_NET_CTRL_HASH_TUNNEL_SET to configure the calculation of the inner header hash.
>  
> +\begin{lstlisting}
>  struct virtnet_hash_tunnel {
>      le32 enabled_tunnel_types;
>  };
>  
>  #define VIRTIO_NET_CTRL_HASH_TUNNEL 7
>   #define VIRTIO_NET_CTRL_HASH_TUNNEL_SET 0
> +\end{lstlisting}
>  
>  Field \field{enabled_tunnel_types} contains the bitmask of encapsulation types enabled for inner header hash.
>  See \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets /
> @@ -1063,16 +1065,16 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>  Hash calculation for incoming packets / Encapsulation types supported/enabled for inner header hash}
>  
>  Encapsulation types applicable for inner header hash:
> -\begin{lstlisting}
> -#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2784    (1 << 0) /* \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]} */
> -#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2890    (1 << 1) /* \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]} */
> -#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_7676    (1 << 2) /* \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]} */
> -#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_UDP     (1 << 3) /* \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]} */
> -#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 4) /* \hyperref[intro:vxlan]{[VXLAN]} */
> -#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN_GPE   (1 << 5) /* \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]} */
> -#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 6) /* \hyperref[intro:geneve]{[GENEVE]} */
> -#define VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP        (1 << 7) /* \hyperref[intro:ipip]{[IPIP]} */
> -#define VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE       (1 << 8) /* \hyperref[intro:nvgre]{[NVGRE]} */
> +\begin{lstlisting}[escapechar=|]
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2784    (1 << 0) /* |\hyperref[intro:rfc2784]{[RFC2784]}| */
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2890    (1 << 1) /* |\hyperref[intro:rfc2890]{[RFC2890]}| */
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_7676    (1 << 2) /* |\hyperref[intro:rfc7676]{[RFC7676]}| */
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_UDP     (1 << 3) /* |\hyperref[intro:rfc8086]{[GRE-in-UDP]}| */
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 4) /* |\hyperref[intro:vxlan]{[VXLAN]}| */
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN_GPE   (1 << 5) /* |\hyperref[intro:vxlan-gpe]{[VXLAN-GPE]}| */
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 6) /* |\hyperref[intro:geneve]{[GENEVE]}| */
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP        (1 << 7) /* |\hyperref[intro:ipip]{[IPIP]}| */
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE       (1 << 8) /* |\hyperref[intro:nvgre]{[NVGRE]}| */
>  \end{lstlisting}
>  
>  \subparagraph{Advice}
> diff --git a/introduction.tex b/introduction.tex
> index 81f07a4fee19..6f10a94b6fde 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -102,18 +102,18 @@ \section{Normative References}\label{sec:Normative References}
>      Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic Cureve Cryptography'', Version 1.0, September 2000.
>  	\newline\url{https://www.secg.org/sec1-v2.pdf}\\
>  
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
> +	\phantomsection\label{intro:rfc8086}\textbf{[GRE-in-UDP]} &
>      GRE-in-UDP Encapsulation. This specifies a method of encapsulating network protocol packets within GRE and UDP headers.
>      This protocol is specified for IPv4 and IPv6, and used as either the payload or delivery protocol.
>  	\newline\url{https://www.rfc-editor.org/rfc/rfc8086}\\


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

