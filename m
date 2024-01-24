Return-Path: <virtio-dev-return-14269-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE18C46CD2
	for <virtio-dev@archiver.kernel.org>; Wed, 24 Jan 2024 10:52:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 757A52B03C
	for <virtio-dev@archiver.kernel.org>; Wed, 24 Jan 2024 10:52:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 515A99867E8
	for <virtio-dev@archiver.kernel.org>; Wed, 24 Jan 2024 10:52:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2D95D9867D8; Wed, 24 Jan 2024 10:52:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1EE199867D9
	for <virtio-dev@lists.oasis-open.org>; Wed, 24 Jan 2024 10:52:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: juTHvlMnNR6EIl90T8J1Mg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706093569; x=1706698369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5OhdqAZPdibFcGl4t/MItssBVyBQeCMYfgb7cNd06A=;
        b=nTosnr8BBr1sSGL84xXOdV9yIBMylP0jsq78R9xIzbRIKRPOs6RelKHHyrAZ8Z0Eg5
         DMye8K2/VgUNHyLCvn/FXMrKha8xpu4W0rP9jtY2KRL7AiIjjhf+QlMLnpLApRu1T0fr
         novK9aNKarzxeevJcqzy5eylGjvDKPs/9BmSsbu8F4h5IX7S8EyK+YC7DAAdtGWbHXZW
         rGFLqUygSBKxItWVR4HK7JMoSBhkXDUSq4qbHKmr4RhXmUnZ3pZUhnNV2hn0p5Sc7cGz
         Or1yaSjgsWdYO2OLnfDsta0/Q00J6KzuarIkwsnajUPZ6vFRduiBHLrTqCTS06OvsLwt
         n/6w==
X-Gm-Message-State: AOJu0YxAJ9xjygXcyS2t6aI/g6kqXVMcr7DPJUNjBrQJzIA2gpSJn+HT
	b+ec1C9+rF25qHrJK0M+C8A++c+RlNkNAxf44Lj6YCNl4sXTn6xRfL+SAqQpBSoIreyZW4moZc0
	t/kY5qCsFXRrZp+/cHHDeLCY4HkjkB8MIjhwrV8WTEDmpPOs/E8hNqKP/LsGJjOg7Nw==
X-Received: by 2002:a17:906:b34d:b0:a30:4e1f:3df3 with SMTP id cd13-20020a170906b34d00b00a304e1f3df3mr659673ejb.98.1706093569187;
        Wed, 24 Jan 2024 02:52:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9md+xHQ+6B3SiPoBZ0l87riHmvdqNhlLCwJuHp4WTdP1JEtQWv3BIBST6XG/dkDPvu8EdwA==
X-Received: by 2002:a17:906:b34d:b0:a30:4e1f:3df3 with SMTP id cd13-20020a170906b34d00b00a304e1f3df3mr659663ejb.98.1706093568725;
        Wed, 24 Jan 2024 02:52:48 -0800 (PST)
Date: Wed, 24 Jan 2024 05:52:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20240124055209-mutt-send-email-mst@kernel.org>
References: <1705323962-96063-1-git-send-email-hengqi@linux.alibaba.com>
 <20240124054505-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240124054505-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v2] virtio-net: support setting coalescing params for
 multiple vqs

On Wed, Jan 24, 2024 at 05:50:28AM -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 15, 2024 at 09:06:02PM +0800, Heng Qi wrote:
> > Currently, when each time the driver attempts to update the coalescing parameters
> > for a vq, it needs to kick the device and wait for the ctrlq response to return.
> > The following path is observed: 1. Driver kicks the device; 2. After the device
> > receives the kick, CPU scheduling occurs and DMA multiple buffers multiple times;
> > 3. The device completes processing and replies with a response.
> > 
> > When large-queue devices issue multiple requests and kick the device frequently,
> > this often interrupt the work of the device-side CPU. In addition, each vq request
> > is processed separately, causing more delays for the CPU to wait for the DMA
> > request to complete.
> > 
> > These interruptions and overhead will strain the CPU responsible for controlling
> > the path of the DPU, especially in multi-device and large-queue scenarios.
> > 
> > To solve the above problems, we internally tried batch request, which merges
> > requests from multiple queues and sends them at once. We conservatively tested
> > 8 queue commands and sent them together. The DPU processing efficiency can be
> > improved by 8 times, which greatly eases the DPU's support for multi-device
> > and multi-queue DIM.
> > 
> > Maintainers may be concerned about whether the batch command method can optimize
> > the above problems: accumulate multiple request commands to kick the device once,
> > and obtain the processing results of the corresponding commands asynchronously.
> > The batch command method is used by us to optimize the CPU overhead of the DIM
> > worker caused by the guest being busy waiting for the command response result.
> > This is a different focus than batch request to solve the problem.
> > 
> > Suggested-by: Xiaoming Zhao <zxm377917@alibaba-inc.com>
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > ---
> > v1->v2: Updated commit log. Due to sensitivity, sorry that can not give the
> >     absolute value directly. @Michael
> > 
> >  device-types/net/description.tex | 26 ++++++++++++++++++++------
> >  1 file changed, 20 insertions(+), 6 deletions(-)
> > 
> > diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> > index aff5e08..b3766c4 100644
> > --- a/device-types/net/description.tex
> > +++ b/device-types/net/description.tex
> > @@ -1667,8 +1667,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> >  for notification coalescing.
> >  
> >  If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated, the driver can
> > -send commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET
> > -for virtqueue notification coalescing.
> > +send commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET and
> > +VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET for virtqueue notification coalescing.
> >  
> >  \begin{lstlisting}
> >  struct virtio_net_ctrl_coal {
> > @@ -1682,11 +1682,17 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> >      struct virtio_net_ctrl_coal coal;
> >  };
> >  
> > +struct virtio_net_ctrl_mrg_coal_vq {
> > +        le16 num_entries; /* indicates number of valid entries */
> > +        struct virtio_net_ctrl_coal_vq entries[];
> > +};
> > +
> >  #define VIRTIO_NET_CTRL_NOTF_COAL 6
> >   #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
> >   #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
> >   #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2
> >   #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
> > + #define VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET 4
> >  \end{lstlisting}
> >  
> >  Coalescing parameters:
> > @@ -1706,6 +1712,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> >  \item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, the structure virtio_net_ctrl_coal_vq is write-only for the driver.
> >  \item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vq_index} and \field{reserved} are write-only
> >        for the driver, and the structure virtio_net_ctrl_coal is read-only for the driver.
> > +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET, the structure virtio_net_ctrl_mrg_coal_vq is write-only for the driver.
> >  \end{itemize}
> >  
> >  The class VIRTIO_NET_CTRL_NOTF_COAL has the following commands:
> > @@ -1716,6 +1723,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> >                                          for an enabled transmit/receive virtqueue whose index is \field{vq_index}.
> >  \item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: use the structure virtio_net_ctrl_coal_vq to get the \field{max_usecs} and \field{max_packets} parameters
> >                                          for an enabled transmit/receive virtqueue whose index is \field{vq_index}.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET: use the structure virtio_net_ctrl_mrg_coal_vq to set the \field{max_usecs} and \field{max_packets} parameters
> > +                                         for \field{num_entries} enabled transmit/receive virtqueues. The corresponding index value
> > +                                         of each configured virtqueue is \field{vq_index}.
> >  \end{enumerate}
> >  
> >  The device may generate notifications more or less frequently than specified by set commands of the VIRTIO_NET_CTRL_NOTF_COAL class.
> > @@ -1782,9 +1792,13 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> >  
> >  The driver MUST set \field{vq_index} to the virtqueue index of an enabled transmit or receive virtqueue.
> >  
> > +The driver MUST set \field{num_entries} to a non-zero value and MUST NOT set \field{num_entries} to
> > +a value greater than the number of enabled transmit and receive virtqueues.
> > +
> >  The driver MUST have negotiated the VIRTIO_NET_F_NOTF_COAL feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET.
> >  
> > -The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
> > +The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL feature when issuing commands
> > +VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
> >  
> >  The driver MUST ignore the values of coalescing parameters received from the VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command if the device responds with VIRTIO_NET_ERR.
> >  
> > @@ -1794,10 +1808,10 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> >  
> >  The device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if it was not able to change the parameters.
> >  
> > -The device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with VIRTIO_NET_ERR if it was not able to change the parameters.
> > +The device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET commands with VIRTIO_NET_ERR if it was not able to change the parameters.
> 
> This one however is vague.
> In fact the addition of VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET made
> VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET
> also vague we just missed this.
> 
> 
> 
> So, it is not clear whether if the device responds with VIRTIO_NET_ERR - it can change
> parameters for some VQs but not others, or does it have to either
> change parameters for all VQs or none at all.
> 
> I think a better sematic is all or nothing.
> 
> So I suggest combining this statement with one of
> VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
> and adding something like
> "in this case, coalescing parameters MUST remain unchanged, 
> for all VQs".
> 
> This bug bothers me. Maybe we should fix it before release?
> 
> I also don't know why we repeat same text for VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
> VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET.

I figured it out, TX/RX are SHOULD.
I will fix TX/RX and you can add the text to this one.


> >  
> > -The device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET commands with
> > -VIRTIO_NET_ERR if the designated virtqueue is not an enabled transmit or receive virtqueue.
> > +The device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET
> > +commands with VIRTIO_NET_ERR if the designated virtqueue is not an enabled transmit or receive virtqueue.
> >  
> >  Upon disabling and re-enabling a transmit virtqueue, the device MUST set the coalescing parameters of the virtqueue
> >  to those configured through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver did not set any TX coalescing parameters, to 0.
> > -- 
> > 1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

