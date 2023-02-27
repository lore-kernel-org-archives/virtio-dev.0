Return-Path: <virtio-dev-return-11319-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED98C7EE23
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 17:36:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6D26E2A891
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 17:36:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 65FD0986610
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 17:36:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5A8CF986478; Mon, 27 Feb 2023 17:36:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4AE3C986561
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Feb 2023 17:36:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: OzuFa4hjMTSuROkiHEPiww-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54p8LLWwo4RHxRPJIRlzuK2A6iDrwbeBTjMeCtftmks=;
        b=gY2fLxJU/Ra6KmzVrcX/0fp+I4VhD0JO5wFwDfXHUlWevxjI9WAWhvsc4UYLMfbapL
         2dXQl6m9TrLhDKcb+vnD8fAfGoIvnCdPqnCx1rqDQpRltHciTP5eocLvjbSpRnlUKX2k
         APa3r59AwMhYqS7uBMd81iwGHc4dmrAvfAFVHR8Fbd9KrpiVv9fwWofTsmPGZE3YjnTB
         kiyxPQTmxnhdOvVLubjmVtt5NSAQdzl+8d0XXHl+ruOdmo4B/PF7OkSmBJJcV2ebujdP
         mYZAb8sW5yBlp75O4dDyZ+nMQw+LoL6BRBlRRAO5tfzIqnHT0wXuxFyIVkylqmuXzNem
         adQA==
X-Gm-Message-State: AO0yUKVN+2FdsavuwwrbMMTXR0d6LA/jaRvnBEvSQd0b9XNYsNWfmdCw
	z4yOv5otNq2kR5yQ2n45JyKlE0rdD/YEDix62iMp/9lM4PcFDUHY0394jomlNaw3BlEbBFbJdS6
	q/BQfOW3i4+vUxCCTu8YFYDiTkqW1
X-Received: by 2002:a5d:4a85:0:b0:2ca:5c9a:a548 with SMTP id o5-20020a5d4a85000000b002ca5c9aa548mr5092640wrq.60.1677519389675;
        Mon, 27 Feb 2023 09:36:29 -0800 (PST)
X-Google-Smtp-Source: AK7set9/XDF6tGhFkc9dQycdYxsmSi6F9VnTNf9nIGrw5JiQwTT7H3plebS43v1EBZkYqwbbn8IbNQ==
X-Received: by 2002:a5d:4a85:0:b0:2ca:5c9a:a548 with SMTP id o5-20020a5d4a85000000b002ca5c9aa548mr5092620wrq.60.1677519389342;
        Mon, 27 Feb 2023 09:36:29 -0800 (PST)
Date: Mon, 27 Feb 2023 12:36:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230227123423-mutt-send-email-mst@kernel.org>
References: <20230223054624.168042-1-parav@nvidia.com>
 <20230223054624.168042-3-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230223054624.168042-3-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 2/3] transport-mmio: Rename QueueNum register
Message-ID: <20230227173625.LSC3r66BjqCeM2qnbQHOvuyfP1Uod84fTqomC8O4dKY@z>

On Thu, Feb 23, 2023 at 07:46:23AM +0200, Parav Pandit wrote:
> Currently, the specification uses virtqueue index and number
> interchangeably to refer to the virtqueue.
> 
> It is better to identify it using one terminology.
> 
> Two registers QueueNumMax and QueueNum actually reflect the queue size
> or queue depth indicating max and actual number of entries in the queue.
> Equivalent register in PCI transport is named differently as queue_size.
> 
> To bring consistency between pci and mmio transport, and to avoid
> confusion between number and index, rename the QueueNumMax and QueueNum
> registers to QueueSizeMax and QueueSize respectively.
> 
> [1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Signed-off-by: Parav Pandit <parav@nvidia.com>

I think this is a good change but it will confuse people
who have e.g. a driver source and are trying to match
it to te spec. Suggestions below


> ---
>  transport-mmio.tex | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/transport-mmio.tex b/transport-mmio.tex
> index 65bae54..c59975e 100644
> --- a/transport-mmio.tex
> +++ b/transport-mmio.tex
> @@ -104,14 +104,14 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>      number of the first queue is zero (0x0).
>    }
>    \hline
> -  \mmioreg{QueueNumMax}{Maximum virtual queue size}{0x034}{R}{%
> +  \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%

I would add something like "Note: this was previously known as QueueNumMax"
and same elsewhere.

>      Reading from the register returns the maximum size (number of
>      elements) of the queue the device is ready to process or
>      zero (0x0) if the queue is not available. This applies to the
>      queue selected by writing to \field{QueueSel}.

>    }
>    \hline
> -  \mmioreg{QueueNum}{Virtual queue size}{0x038}{W}{%
> +  \mmioreg{QueueSize}{Virtual queue size}{0x038}{W}{%
>      Queue size is the number of elements in the queue.
>      Writing to this register notifies the device what size of the
>      queue the driver will use. This applies to the queue selected by
> @@ -459,7 +459,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
>  .
>    }
>    \hline
> -  \mmioreg{QueueNumMax}{Maximum virtual queue size}{0x034}{R}{%
> +  \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
>      Reading from the register returns the maximum size of the queue
>      the device is ready to process or zero (0x0) if the queue is not
>      available. This applies to the queue selected by writing to

Same here.

> @@ -467,7 +467,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
>      (0x0), so when the queue is not actively used.
>    }
>    \hline
> -  \mmioreg{QueueNum}{Virtual queue size}{0x038}{W}{%
> +  \mmioreg{QueueSize}{Virtual queue size}{0x038}{W}{%
>      Queue size is the number of elements in the queue.
>      Writing to this register notifies the device what size of the
>      queue the driver will use. This applies to the queue selected by

And here.

> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

