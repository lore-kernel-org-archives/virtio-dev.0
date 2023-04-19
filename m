Return-Path: <virtio-dev-return-12307-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A14C77B78
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 07:13:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BA7AD7DD70
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 07:13:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD12F9865E2
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 07:13:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9FED9986416; Wed, 19 Apr 2023 07:13:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 900E298641E
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Apr 2023 07:13:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: tkDPGxorNOmp2qi29QfnXQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681888409; x=1684480409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKmzGwOgs4zG44hrQY54Yy5GveTXnp6eXlSWoDicBqg=;
        b=LihUQccjEaD/AOD3GgDgAo+ivJVz1s0arYAQm/a/nGlcKOkm3Frx5vHfqVY2WDjZ17
         OO1FQz2cqWLohf0zEz+SVOaF2SAVQTZHNbXVGV+799aqmu8y2Od2tAWeGySNoX54pr4U
         4aawbr5BOXjIke6bGnXHOaJ6EUe1001dGdkTeOx4jybrJNUzySqK95MPnZv4Ccm0VWtg
         ZOJSi0HNyNZiwITA7B2AAsIDBS2fiqgoD8ZDJiWzDOZO9J8eJsN7qWRHbIXr/NBu0ISe
         gdtMr2o56qg5pKKMboY+yIIS/R8aCLFj5pN4Hjg+dGQivmLAugM3X8lvPNFidKpWgctf
         8Gpg==
X-Gm-Message-State: AAQBX9cUPp+6XDsa1nCYUHlyA2dPuRTP95M74couke5fCjqrvVUrwh2S
	1ftz+SXpjxIgJTsDTIKBtMqHwdXrsOUghw3TVfwHe74yP6/IUjE9BRVtcr6ouIGVgOyGaGONOGd
	1fS/t+pcp/3m2a0GaAQAIVrkKH28d
X-Received: by 2002:adf:dbce:0:b0:2f6:bf04:c8cc with SMTP id e14-20020adfdbce000000b002f6bf04c8ccmr3934229wrj.55.1681888409308;
        Wed, 19 Apr 2023 00:13:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350YyERGMMXy3SyewXtXiWwUzPuB/53tU6z4/99303NQjD/xwhZkfxbIzL5MqHWQ2/fBwgLAemw==
X-Received: by 2002:adf:dbce:0:b0:2f6:bf04:c8cc with SMTP id e14-20020adfdbce000000b002f6bf04c8ccmr3934200wrj.55.1681888408903;
        Wed, 19 Apr 2023 00:13:28 -0700 (PDT)
Date: Wed, 19 Apr 2023 03:13:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
	Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230419031228-mutt-send-email-mst@kernel.org>
References: <20230419015638.919627-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230419015638.919627-1-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v1] transport-mmio: Replace virtual queue with virtqueue

On Wed, Apr 19, 2023 at 04:56:38AM +0300, Parav Pandit wrote:
> Basic facilities define the virtqueue construct for device <-> driver
> communication.
> 
> PCI transport and individual devices description also refers to it as
> virtqueue.
> 
> MMIO refers to it as 'virtual queue'.
> 
> Align MMIO transport description to call such object a virtqueue.
> 
> This patch is on top of [1].
> 
> [1] https://lists.oasis-open.org/archives/virtio-dev/202304/msg00407.html
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

It's borderline but when in doubt, vote. Fixes tag with a github issue?


> ---
> changelog:
> v0->v1:
> - rebased
> - added Stefan's RB tag
> ---
>  transport-mmio.tex | 50 +++++++++++++++++++++++-----------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/transport-mmio.tex b/transport-mmio.tex
> index 2d24b4c..f5aaace 100644
> --- a/transport-mmio.tex
> +++ b/transport-mmio.tex
> @@ -108,15 +108,15 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>      bits accessible by writing to \field{DriverFeatures}.
>    }
>    \hline
> -  \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
> -    Writing to this register selects the virtual queue that the
> +  \mmioreg{QueueSel}{Virtqueue index}{0x030}{W}{%
> +    Writing to this register selects the virtqueue that the
>      following operations on \field{QueueSizeMax},
>      \field{QueueSize}, \field{QueueReady},
>      \field{QueueDescLow}, \field{QueueDescHigh}, \field{QueueDriverlLow}, \field{QueueDriverHigh},
>      \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueReset} apply to.
>    }
>    \hline
> -  \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
> +  \mmioreg{QueueSizeMax}{Maximum virtqueue size}{0x034}{R}{%
>      Reading from the register returns the maximum size (number of
>      elements) of the queue the device is ready to process or
>      zero (0x0) if the queue is not available. This applies to the
> @@ -126,7 +126,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>      \end{note}
>    }
>    \hline
> -  \mmioreg{QueueSize}{Virtual queue size}{0x038}{W}{%
> +  \mmioreg{QueueSize}{Virtqueue size}{0x038}{W}{%
>      Queue size is the number of elements in the queue.
>      Writing to this register notifies the device what size of the
>      queue the driver will use. This applies to the queue selected by
> @@ -136,9 +136,9 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>      \end{note}
>    }
>    \hline
> -  \mmioreg{QueueReady}{Virtual queue ready bit}{0x044}{RW}{%
> +  \mmioreg{QueueReady}{Virtqueue ready bit}{0x044}{RW}{%
>      Writing one (0x1) to this register notifies the device that it can
> -    execute requests from this virtual queue. Reading from this register
> +    execute requests from this virtqueue. Reading from this register
>      returns the last value written to it. Both read and write
>      accesses apply to the queue selected by writing to \field{QueueSel}.
>    }
> @@ -166,7 +166,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>      \begin{description}
>        \item[Used Buffer Notification] - bit 0 - the interrupt was asserted
>          because the device has used a buffer
> -        in at least one of the active virtual queues.
> +        in at least one of the active virtqueues.
>        \item [Configuration Change Notification] - bit 1 - the interrupt was
>          asserted because the configuration of the device has changed.
>      \end{description}
> @@ -187,21 +187,21 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>      See also p. \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Device Initialization}~\nameref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Device Initialization}.
>    }
>    \hline
> -  \mmiodreg{QueueDescLow}{QueueDescHigh}{Virtual queue's Descriptor Area 64 bit long physical address}{0x080}{0x084}{W}{%
> +  \mmiodreg{QueueDescLow}{QueueDescHigh}{Virtqueue's Descriptor Area 64 bit long physical address}{0x080}{0x084}{W}{%
>      Writing to these two registers (lower 32 bits of the address
>      to \field{QueueDescLow}, higher 32 bits to \field{QueueDescHigh}) notifies
>      the device about location of the Descriptor Area of the queue
>      selected by writing to \field{QueueSel} register.
>    }
>    \hline
> -  \mmiodreg{QueueDriverLow}{QueueDriverHigh}{Virtual queue's Driver Area 64 bit long physical address}{0x090}{0x094}{W}{%
> +  \mmiodreg{QueueDriverLow}{QueueDriverHigh}{Virtqueue's Driver Area 64 bit long physical address}{0x090}{0x094}{W}{%
>      Writing to these two registers (lower 32 bits of the address
>      to \field{QueueDriverLow}, higher 32 bits to \field{QueueDriverHigh}) notifies
>      the device about location of the Driver Area of the queue
>      selected by writing to \field{QueueSel}.
>    }
>    \hline
> -  \mmiodreg{QueueDeviceLow}{QueueDeviceHigh}{Virtual queue's Device Area 64 bit long physical address}{0x0a0}{0x0a4}{W}{%
> +  \mmiodreg{QueueDeviceLow}{QueueDeviceHigh}{Virtqueue's Device Area 64 bit long physical address}{0x0a0}{0x0a4}{W}{%
>      Writing to these two registers (lower 32 bits of the address
>      to \field{QueueDeviceLow}, higher 32 bits to \field{QueueDeviceHigh}) notifies
>      the device about location of the Device Area of the queue
> @@ -235,7 +235,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>      0xffffffffffffffff.
>    }
>    \hline
> -  \mmioreg{QueueReset}{Virtual queue reset bit}{0x0c0}{RW}{%
> +  \mmioreg{QueueReset}{Virtqueue reset bit}{0x0c0}{RW}{%
>      If VIRTIO_F_RING_RESET has been negotiated, writing one (0x1) to this
>      register selectively resets the queue. Both read and write accesses
>      apply to the queue selected by writing to \field{QueueSel}.
> @@ -274,7 +274,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>  The device MUST change value returned in \field{ConfigGeneration} if there is any risk of a
>  driver seeing an inconsistent configuration state.
>  
> -The device MUST NOT access virtual queue contents when \field{QueueReady} is zero (0x0).
> +The device MUST NOT access virtqueue contents when \field{QueueReady} is zero (0x0).
>  
>  If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
>  \field{QueueReset} on reset.
> @@ -359,7 +359,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
>  
>  \subsubsection{Virtqueue Configuration}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Virtqueue Configuration}
>  
> -The driver will typically initialize the virtual queue in the following way:
> +The driver will typically initialize the virtqueue in the following way:
>  
>  \begin{enumerate}
>  \item Select the queue by writing its index to \field{QueueSel}.
> @@ -422,7 +422,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
>  
>  The legacy MMIO transport used page-based addressing, resulting
>  in a slightly different control register layout, the device
> -initialization and the virtual queue configuration procedure.
> +initialization and the virtqueue configuration procedure.
>  
>  Table \ref{tab:Virtio Transport Options / Virtio Over MMIO / MMIO Device Legacy Register Layout}
>  presents control registers layout, omitting
> @@ -468,14 +468,14 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
>      (see QueuePFN).
>    }
>    \hline
> -  \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
> -    Writing to this register selects the virtual queue that the
> +  \mmioreg{QueueSel}{Virtqueue index}{0x030}{W}{%
> +    Writing to this register selects the virtqueue that the
>      following operations on the \field{QueueSizeMax},
>      \field{QueueSize}, \field{QueueAlign}
>      and \field{QueuePFN} registers apply to.
>    }
>    \hline
> -  \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
> +  \mmioreg{QueueSizeMax}{Maximum virtqueue size}{0x034}{R}{%
>      Reading from the register returns the maximum size of the queue
>      the device is ready to process or zero (0x0) if the queue is not
>      available. This applies to the queue selected by writing to
> @@ -486,7 +486,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
>      \end{note}
>    }
>    \hline
> -  \mmioreg{QueueSize}{Virtual queue size}{0x038}{W}{%
> +  \mmioreg{QueueSize}{Virtqueue size}{0x038}{W}{%
>      Queue size is the number of elements in the queue.
>      Writing to this register notifies the device what size of the
>      queue the driver will use. This applies to the queue selected by
> @@ -496,15 +496,15 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
>      \end{note}
>    }
>    \hline
> -  \mmioreg{QueueAlign}{Used Ring alignment in the virtual queue}{0x03c}{W}{%
> +  \mmioreg{QueueAlign}{Used Ring alignment in the virtqueue}{0x03c}{W}{%
>      Writing to this register notifies the device about alignment
>      boundary of the Used Ring in bytes. This value should be a power
>      of 2 and applies to the queue selected by writing to \field{QueueSel}.
>    }
>    \hline
> -  \mmioreg{QueuePFN}{Guest physical page number of the virtual queue}{0x040}{RW}{%
> +  \mmioreg{QueuePFN}{Guest physical page number of the virtqueue}{0x040}{RW}{%
>      Writing to this register notifies the device about location of the
> -    virtual queue in the Guest's physical address space. This value
> +    virtqueue in the Guest's physical address space. This value
>      is the index number of a page starting with the queue
>      Descriptor Table. Value zero (0x0) means physical address zero
>      (0x00000000) and is illegal. When the driver stops using the
> @@ -536,15 +536,15 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
>    \hline
>  \end{longtable}
>  
> -The virtual queue page size is defined by writing to \field{GuestPageSize},
> +The virtqueue page size is defined by writing to \field{GuestPageSize},
>  as written by the guest. The driver does this before the
> -virtual queues are configured.
> +virtqueues are configured.
>  
> -The virtual queue layout follows
> +The virtqueue layout follows
>  p. \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout},
>  with the alignment defined in \field{QueueAlign}.
>  
> -The virtual queue is configured as follows:
> +The virtqueue is configured as follows:
>  \begin{enumerate}
>  \item Select the queue by writing its index to \field{QueueSel}.
>  
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

