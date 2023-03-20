Return-Path: <virtio-dev-return-11652-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FEAC6FD1D
	for <virtio-dev@archiver.kernel.org>; Mon, 20 Mar 2023 18:37:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A400B71C86
	for <virtio-dev@archiver.kernel.org>; Mon, 20 Mar 2023 18:37:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 855B398620E
	for <virtio-dev@archiver.kernel.org>; Mon, 20 Mar 2023 18:37:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7229D98616A; Mon, 20 Mar 2023 18:37:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F505986198
	for <virtio-dev@lists.oasis-open.org>; Mon, 20 Mar 2023 18:37:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: KlcyiEmRMoyLf27Rqmv9ZA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679337453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=he7WApaTvKfakRA2Km31F5SY3RDRpIu5d3I9IY28Ofo=;
        b=T1eAQvqXrEorGkdXJKBoH449W3eq2/hs/DQSfngJUPj+RFqyJz8hFmDbnXr4wlwStU
         D6SUKhtD1IJ+hIPUKJ1pPKmq8uLx+XNIbfoFSvt8A7Jk5987O6rnAgO8Xczv7WC+ugdt
         spy7ZCc9qRk9/AwatfEtjUVvbJSDsFfR2TKh5Tv1gEiTtOWl0QfUoTIHuy40naJb/BGA
         tFwUN3ZqHEKlOvzaNoi3L1BjAyeMMAEDSvgqVIFunuj2+9EHgRmpXGmIRTZLavyDzZ+v
         EezjdHvXU0NRwjrPpAvIalXRaW1x8fODOFc9T3LS9e17S1rGtbpFY7vMZ3hkGFxfZaIN
         v0IA==
X-Gm-Message-State: AO0yUKVE3QbsLA9QdA7+DpebZT/qqHMKLyF57iOohHVrCuFhzHujuoAy
	cBApwmgt/tMnzMV7vmZi5Nv2xRYvc+ERQxNVmeN3VFXicbfqnTJnJNb2ajpKXfaGiq8pb1SP5Wf
	GUNcT72p+0SCW9JMWjO7x+syQGAeU
X-Received: by 2002:a7b:ce8a:0:b0:3df:de28:f819 with SMTP id q10-20020a7bce8a000000b003dfde28f819mr439495wmj.15.1679337453600;
        Mon, 20 Mar 2023 11:37:33 -0700 (PDT)
X-Google-Smtp-Source: AK7set99OGNycRJincKP7lDyA5fe0Wt/ZL+jNOPuFU/6G7HP2CtF03XfqwNGioKe8n8P+xqWDVHj0A==
X-Received: by 2002:a7b:ce8a:0:b0:3df:de28:f819 with SMTP id q10-20020a7bce8a000000b003dfde28f819mr439483wmj.15.1679337453252;
        Mon, 20 Mar 2023 11:37:33 -0700 (PDT)
Date: Mon, 20 Mar 2023 14:37:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org,
	Parav Pandit <parav@nvidia.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	David Edmondson <david.edmondson@oracle.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230320143239-mutt-send-email-mst@kernel.org>
References: <20230312124628.8527-1-hengqi@linux.alibaba.com>
 <87cz53js85.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87cz53js85.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v12] virtio-net: support the virtqueue
 coalescing moderation

On Mon, Mar 20, 2023 at 05:35:38PM +0100, Cornelia Huck wrote:
> On Sun, Mar 12 2023, Heng Qi <hengqi@linux.alibaba.com> wrote:
> 
> > Currently, coalescing parameters are grouped for all transmit and receive
> > virtqueues. This patch supports setting or getting the parameters for a
> > specified virtqueue, and a typical application of this function is netdim[1].
> >
> > When the traffic between virtqueues is unbalanced, for example, one virtqueue
> > is busy and another virtqueue is idle, then it will be very useful to
> > control coalescing parameters at the virtqueue granularity.
> >
> > [1] https://docs.kernel.org/networking/net_dim.html
> >
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Reviewed-by: Parav Pandit <parav@nvidia.com>
> 
> [Apologies for only reviewing this right now]
> 
> > @@ -1519,25 +1522,63 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> >      le32 max_usecs;
> >  };
> >  
> > +struct virtio_net_ctrl_coal_vq {
> > +    le16 vqn;
> > +    le16 reserved;
> > +    struct virtio_net_ctrl_coal coal;
> > +};
> > +
> >  #define VIRTIO_NET_CTRL_NOTF_COAL 6
> >   #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
> >   #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
> > + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2
> > + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
> >  \end{lstlisting}
> >  
> >  Coalescing parameters:
> >  \begin{itemize}
> > +\item \field{vqn}: The virtqueue number of an enabled transmit or receive virtqueue.
> 
> As the commands obviously cannot target a control vq, I think we need a
> statement on what the device is supposed to be doing if the driver puts
> the number of the control q (or indeed an invalid number) here?


Not necessarily, we don't always require input validation. It's enough
to forbid driver from doing this (as you suggest below).

> >  \item \field{max_usecs} for RX: Maximum number of microseconds to delay a RX notification.
> >  \item \field{max_usecs} for TX: Maximum number of microseconds to delay a TX notification.
> >  \item \field{max_packets} for RX: Maximum number of packets to receive before a RX notification.
> >  \item \field{max_packets} for TX: Maximum number of packets to send before a TX notification.
> >  \end{itemize}
> >  
> > -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
> > +\field{reserved} is reserved and it is ignored by a device.
> 
> s/a/the/
> 
> > +
> > +Read/Write attributes for coalescing parameters:
> > +\begin{itemize}
> > +\item For commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET, the structure virtio_net_ctrl_coal is write-only for a driver.
> 
> s/a/the/
> 
> > +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, the structure virtio_net_ctrl_coal_vq is write-only for a driver.
> 
> s/a/the/
> 
> > +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vqn} and \field{reserved} are write-only
> > +      for a driver, and the structure virtio_net_ctrl_coal is read-only for the driver.
> 
> s/a/the/ (otherwise, this is kind of inconsistent)
> 
> > +\end{itemize}
> > +
> > +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
> 
> Instead of giving the exact number of commands, maybe use "the following
> commands" instead?
> 
> >  \begin{enumerate}
> > -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and \field{max_packets} parameters for all transmit virtqueues.
> > -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and \field{max_packets} parameters for all receive virtqueues.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: use the structure virtio_net_ctrl_coal to set the \field{max_usecs} and \field{max_packets} parameters for all transmit virtqueues.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: use the structure virtio_net_ctrl_coal to set the \field{max_usecs} and \field{max_packets} parameters for all receive virtqueues.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: use the structure virtio_net_ctrl_coal_vq to set the \field{max_usecs} and \field{max_packets} parameters
> > +                                        for an enabled transmit/receive virtqueue whose number is \field{vqn}.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: use the structure virtio_net_ctrl_coal_vq to get the \field{max_usecs} and \field{max_packets} parameters
> > +                                        for an enabled transmit/receive virtqueue whose number is \field{vqn}.
> >  \end{enumerate}
> >  
> > +The device may generate notifications more or less frequently than specified by set commands of the VIRTIO_NET_CTRL_NOTF_COAL class.
> > +
> > +If coalescing parameters are being set, the device applies the last coalescing parameters set for a
> > +virtqueue, regardless of the command used to set the parameters. Use the following command sequence
> > +with 2 pairs of virtqueues as an example:
> 
> s/2/two/
> 
> > +Each of the following commands sets \field{max_usecs} and \field{max_packets} parameters for virtqueues.
> > +\begin{itemize}
> > +\item Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets coalescing parameters for virtqueues having vqn 0 and vqn 2. Virtqueues having vqn 1 and vqn 3 retain their previous parameters.
> > +\item Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} = 0 sets coalescing parameters for virtqueue having vqn 0. Virtqueue having vqn 2 retains the parameters from command1.
> > +\item Command3: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} = 0, the device responds with coalescing parameters of vqn 0 set by command2.
> > +\item Command4: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} = 1 sets coalescing parameters for virtqueue having vqn 1. Virtqueue having vqn 3 retains its previous parameters.
> > +\item Command5: VIRTIO_NET_CTRL_NOTF_COAL_TX_SET sets coalescing parameters for virtqueues having vqn 1 and vqn 3, and overrides the parameters set by command4.
> > +\item Command6: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} = 1, the device responds with coalescing parameters of vqn 1 set by command5.
> > +\end{itemize}
> > +
> >  \subparagraph{Operation}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / Operation}
> >  
> >  The device sends a used buffer notification once the notification conditions are met and if the notifications are not suppressed as explained in \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}.
> > @@ -1585,14 +1626,33 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> >  
> >  \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
> >  
> > -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
> > +A driver MUST negotiate the VIRTIO_NET_F_NOTF_COAL feature before issuing commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRIO_NET_CTRL_NOTF_COAL_RX_SET.
> 
> s/VIRIO/VIRTIO/
> 
> > +
> > +A driver MUST negotiate the VIRTIO_NET_F_VQ_NOTF_COAL feature before issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRIO_NET_CTRL_NOTF_COAL_VQ_GET.
> 
> s/VIRIO/VIRTIO/
> 
> I'm not sure whether we should be expressing this via 'before' -- it's
> not like the driver can negotiate the feature bit if it realizes later
> that it wants to issue the command. IOW, I'd prefer the 'not negotiated'
> -> 'MUST NOT issue' construct, but I'm not dead set on it.

I don't like double negation myself. Don't do A if you don't do B is
less clear than "Do B before A".

> 
> > +
> > +A driver MUST ignore the values of coalescing parameters received from the VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command if a device responds with VIRTIO_NET_ERR.
> 
> Do we need to mandate here that the driver MUST NOT put anything else
> but the number of an enabled transmit or receive virtqueue into the vqn
> field?


I think it's a good idea.

> (Generally, I'd prefer "The driver" instead of "A driver" as well, but
> that might be a matter of taste.)


Check the surrounding text, and follow that example.

> >  
> >  \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
> >  
> > -A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with VIRTIO_NET_ERR if it was not able to change the parameters.
> > +A device MUST ignore \field{reserved}.
> > +
> > +A device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if it was not able to change the parameters.
> > +
> > +A device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with VIRTIO_NET_ERR if it was not able to change the parameters.
> > +
> > +A device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET commands with VIRTIO_NET_ERR if the given virtqueue is disabled.
> 
> s/given/designated/ ?
> 
> What should the device do if the virtqueue is invalid (i.e. it is the
> control vq?) I think we either need to add a statement explicitly
> forbidding that to the driver conformance section, or specify that the
> device MUST return an error here.

I prefer forbidding this from driver. Device should be free to
handle this in a variety of ways.


> > +
> > +Upon disabling and re-enabling the transmit virtqueue, the device MUST set the coalescing parameters of the virtqueue
> > +to those configured through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver did not set any TX coalescing parameters, to 0.
> 
> "a transmit virtqueue" ?
> 
> > +
> > +Upon disabling and re-enabling the receive virtqueue, the device MUST set the coalescing parameters of the virtqueue
> > +to those configured through the VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command, or, if the driver did not set any RX coalescing parameters, to 0.
> 
> "a receive virtqueue" ?
> 
> >  
> >  A device SHOULD NOT send used buffer notifications to the driver if the notifications are suppressed, even if the notification conditions are met.
> 
> Generally, I'd prefer "The device" here as well.
> 
> >  
> > +The behavior of the device in response to set commands of the VIRTIO_NET_CTRL_NOTF_COAL class is best-effort:
> > +the device MAY generate notifications more or less frequently than specified.
> > +
> >  Upon reset, a device MUST initialize all coalescing parameters to 0.
> >  
> >  \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
> 
> There are a couple of typos and some style issues here which we could
> fix with an update on top, but I'd really like some clarity regarding
> invalid virtqueues first.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

