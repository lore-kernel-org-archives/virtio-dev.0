Return-Path: <virtio-dev-return-13763-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C67EDE9A7
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 11:25:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6BF192AEDE
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 11:25:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4EF1D98664A
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 11:25:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 35AB798402B; Thu, 14 Sep 2023 11:25:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 24CDC98663D
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Sep 2023 11:25:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: NCeSsjrZPI60SdDtSrf8qA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690731; x=1695295531;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuyEPQxMt1y0DmvZ0XhBGXWtgCV+md2gSPKQyemdQao=;
        b=P+EstVSnRU3OMY9aDFv3CulZHCrdQ+0vlQdsY9ktxbjvlyHdXF6fjIDWM/bVZ1+xSB
         EY5VO8rH6NSDXq/GCGTjnHLnB9ExbJrIv04VppKAp338MKKepW8J214A0MY/fPTSUbQp
         RH2oFpBjsOKOE3jc6BU2S3N79u9hJKrkV1rWzJsv8Ho1IlpWEPfj6AH6YRvMghG51xNL
         Sfh716aOrRipnj8PrJ821SdcgHSwhq8c1HrBKzBUxlqk+Bi/ARrdi46e87d6ybUBXVsX
         O1DhuZGkxMGI8w4oUYFYeRSgO45F/Vj8/0NfuhZxLOilYV5uigZQM8vDdHhdAikv8VNS
         ck2g==
X-Gm-Message-State: AOJu0Ywrzg3NpqITu9wAyNh8f28WUXNLjAyPxAqcR5+sK+mabueDr+nJ
	3B/Z2w9en5kPv4hJx996AvobEQOLqLg7Vm7tVwsTsjaZVATQhxOAwK2slb4XYaIvNTiSik6Fs/r
	Dv1XB7a1L1pF1vath2vaQB4dlmAV2
X-Received: by 2002:ac2:4248:0:b0:502:d84d:e893 with SMTP id m8-20020ac24248000000b00502d84de893mr4271119lfl.36.1694690731419;
        Thu, 14 Sep 2023 04:25:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvcgJ9fFTHlmcUtl8PxdOAsPrFdGThBy5AhhrkGWB8jdNqoo6Jo6tW+k8ab88/SeYpZgPfDw==
X-Received: by 2002:ac2:4248:0:b0:502:d84d:e893 with SMTP id m8-20020ac24248000000b00502d84de893mr4271107lfl.36.1694690731022;
        Thu, 14 Sep 2023 04:25:31 -0700 (PDT)
Date: Thu, 14 Sep 2023 07:25:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, cohuck@redhat.com,
	stefanha@redhat.com, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Message-ID: <20230914071439-mutt-send-email-mst@kernel.org>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-2-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20230906081637.32185-2-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 1/5] virtio: introduce vq state as basic
 facility

On Wed, Sep 06, 2023 at 04:16:33PM +0800, Zhu Lingshan wrote:
> This patch adds new device facility to save and restore virtqueue
> state. The virtqueue state is split into two parts:
> 
> - The available state: The state that is used for read the next
>   available buffer.
> - The used state: The state that is used for make buffer used.
> 
> This will simply the transport specific method implementation. E.g two
> le16 could be used instead of a single le32). For split virtqueue, we
> only need the available state since the used state is implemented in
> the virtqueue itself (the used index).

hmm no, simply because when ring is not running and when
buffers are processed in order, last avail == used.

> For packed virtqueue, we need
> both the available state and the used state.
> 
> Those states are required to implement live migration support for
> virtio device.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>



> ---
>  content.tex | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index 0a62dce..0e492cd 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -502,6 +502,71 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
>  types. It is RECOMMENDED that devices generate version 4
>  UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
>  
> +\section{Virtqueue State}\label{sec:Virtqueues / Virtqueue State}
> +
> +When VIRTIO_F_QUEUE_STATE has been negotiated, the driver can set and
> +get the device internal virtqueue state through the following
> +fields. The implementation of the interfaces is transport specific.
> +
> +\subsection{\field{Available State} Field}
> +
> +The available state field is two bytes of virtqueue state that is used by
> +the device to read the next available buffer.
> +
> +When VIRTIO_RING_F_PACKED is not negotiated, it contains:
> +
> +\begin{lstlisting}
> +le16 last_avail_idx;
> +\end{lstlisting}
> +
> +The \field{last_avail_idx} field is the free-running available ring
> +index where the device will read the next available head of a
> +descriptor chain.

I dislike how this pokes at split-ring.txt externally.
Will make it harder to add new formats down the road.



> +
> +See also \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Available Ring}.
>
> +When VIRTIO_RING_F_PACKED is negotiated, it contains:
> +
> +\begin{lstlisting}
> +le16 {
> +  last_avail_idx : 15;
> +  last_avail_wrap_counter : 1;
> +};
> +\end{lstlisting}
> +
> +The \field{last_avail_idx} field is the free-running location
> +where the device read the next descriptor from the virtqueue descriptor ring.
> +
> +The \field{last_avail_wrap_counter} field is the last driver ring wrap
> +counter that was observed by the device.
> +
> +See also \ref{sec:Packed Virtqueues / Driver and Device Ring Wrap Counters}.


> +\subsection{\field{Used State} Field}
> +
> +The used state field is two bytes of virtqueue state that is used by
> +the device when marking a buffer used.
> +
> +When VIRTIO_RING_F_PACKED is negotiated, the used state contains:
> +
> +\begin{lstlisting}
> +le16 {
> +  used_idx : 15;
> +  used_wrap_counter : 1;
> +};
> +\end{lstlisting}
> +
> +The \field{used_idx} field is the free-running location where the device write the next
> +used descriptor to the descriptor ring.
> +
> +The \field{used_wrap_counter} field is the wrap counter that is used
> +by the device.
> +
> +See also \ref{sec:Packed Virtqueues / Driver and Device Ring Wrap Counters}.
> +
> +When VIRTIO_RING_F_PACKED is not negotiated, the 16-bit value of \field{used_idx}
> +is always 0
> +
>  \input{admin.tex}
>  
>  \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
> -- 
> 2.35.3
> 
> 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

