Return-Path: <virtio-dev-return-11329-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21EFC64EC7
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Feb 2023 07:48:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 09B3C2AC9D
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Feb 2023 07:48:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E2917986627
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Feb 2023 07:48:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C4471983EFA; Tue, 28 Feb 2023 07:48:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AF184986601
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Feb 2023 07:48:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: DzjFRLNUOaaN9H3akPBBFQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677570478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmFpRtCjzUmb0P2ixEPAWU6n1DnKZzhmAMg0PGPRiy4=;
        b=PTXMQd4L2BfG2k/uslYu3u/ob5vpwAJafxd+HfFOXdTl8nwrPUxr9pkGQnLWI1mzTG
         h7rasd+D1YrBytniQqcNipPYqb2KKPT9B41C9EA8C6trvNtwVrQyXpP4eDmSn/xu2jWb
         pHX1lmE9vh75DV9I9jOKBqVDy1IlbbpzL4g4GkX1weZoWEDGYrCgL5Hu3LsEFJRMIvoo
         XoJ6AvZuckW/AveYjFa59inp1I4e89CyApNzMJ13KN0vASLTUDJKGL1MEXyz31dgr3t0
         Q7p5kbFW6sY3zdByNKfp+dIZiS1aQT8ZxPHbXY0CdeuapdybGI2BPOWfOE380SqBMis2
         sK0A==
X-Gm-Message-State: AO0yUKWezeR8w7/DwFYIN7f3SgigAf/5mjrqi1yE3jtzpfVDVScDgDbe
	OLa8mXW/pMwJAQUftkxctEPg77VBJlC60IGJ7GjMA4nMZ/W7lu8MUewvzQKvmKc9UAuhw/IFuQl
	bLcAmafDaFGEGjv9bx9rlo/R5SJCp
X-Received: by 2002:a17:907:7f93:b0:8b1:3c99:76c0 with SMTP id qk19-20020a1709077f9300b008b13c9976c0mr1945080ejc.64.1677570478665;
        Mon, 27 Feb 2023 23:47:58 -0800 (PST)
X-Google-Smtp-Source: AK7set9S/fuWM7GC5FRx92L+0NPW9hiJdF2C5eRVn2rWwhXy2Ly/uwFCemDrL1cVtmYGQIkWfBTODA==
X-Received: by 2002:a17:907:7f93:b0:8b1:3c99:76c0 with SMTP id qk19-20020a1709077f9300b008b13c9976c0mr1945051ejc.64.1677570478195;
        Mon, 27 Feb 2023 23:47:58 -0800 (PST)
Date: Tue, 28 Feb 2023 02:47:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	David Edmondson <david.edmondson@oracle.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230228023225-mutt-send-email-mst@kernel.org>
References: <20230226093724.44717-1-hengqi@linux.alibaba.com>
 <PH0PR12MB548149DF3FCB29805E442F75DCAC9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548149DF3FCB29805E442F75DCAC9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v9] virtio-net: support the virtqueue coalescing
 moderation
Message-ID: <20230228074754.zQIpkarAkw342py6hZZvVT1OoYFyGVJYj1zXZDYlMIw@z>

On Tue, Feb 28, 2023 at 01:40:29AM +0000, Parav Pandit wrote:
> 
> > From: Heng Qi <hengqi@linux.alibaba.com>
> > Sent: Sunday, February 26, 2023 4:37 AM
> 
> > +# Read/Write attributes for coalescing parameters \begin{itemize} \item
> Hash # above is not needed. Please remove.
> 
> > +For commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> > VIRTIO_NET_CTRL_NOTF_COAL_RX_SET, \field{max_usecs}
> > +      and \field{max_packets} are write-only for a driver.
> > +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, \field{vqn},
> > \field{reserved}, \field{max_usecs}
> > +      and \field{max_packets} are write-only for a driver.
> > +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vqn}
> > and \field{reserved} are write-only
> > +      for a driver, and, \field{max_usecs} and \field{max_packets} are read-only
> > for the driver.
> > +\end{itemize}
> Instead of describing each individual fields of the structure struct virtio_net_ctrl_coal coal as read-only or write-only, better to say the struct itself as read/write only.

I don't see how you can reasonably do this. Which fields are RO and
which WO depends on the command.

> This way when/if in the future, if struct virtio_net_ctrl_coal coal extends, no need to rewrite this section of the spec.

Exactly the reverse.
If you specify RO/WO for each field then you don't need to touch
existing description when adding fields.
If you write in one place that all of struct is RO, when you add
WO fields you need to change it.


> > +
> >  Coalescing parameters:
> >  \begin{itemize}
> > +\item \field{vqn}: The virtqueue number of an enabled transmit or receive
> > virtqueue.
> >  \item \field{max_usecs} for RX: Maximum number of microseconds to delay a
> > RX notification.
> >  \item \field{max_usecs} for TX: Maximum number of microseconds to delay a
> > TX notification.
> >  \item \field{max_packets} for RX: Maximum number of packets to receive
> > before a RX notification.
> >  \item \field{max_packets} for TX: Maximum number of packets to send before
> > a TX notification.
> >  \end{itemize}
> > 
> > -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
> > +\field{reserved} is reserved and it is ignored by a device.
> > +
> > +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
> >  \begin{enumerate}
> > -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and
> > \field{max_packets} parameters for all transmit virtqueues.
> > -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and
> > \field{max_packets} parameters for all receive virtqueues.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and
> > \field{max_packets} parameters for all transmit virtqueues, and values of
> > +                                        coalescing parameters are recorded as TX global values
> > by a device.
> "recording TX global values" is not conveying anything more as "all transmit virtqueues" is already mentioned.
> The original text without "recorded as Tx global values" is just fine. Same for the RX below.

I agree.

> > +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and
> > \field{max_packets} parameters for all receive virtqueues, and values of
> > +                                        coalescing parameters are recorded as RX global values
> > by a device.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: set the \field{max_usecs} and
> > \field{max_packets} parameters for an enabled transmit/receive
> > +                                        virtqueue whose number is \field{vqn}, and do not
> > change the TX/RX global values.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: the device returns the
> > \field{max_usecs} and \field{max_packets} parameters for an enabled
> > +                                        transmit/receive virtqueue whose number is \field{vqn}.
> >  \end{enumerate}
> > 
> > +If coalescing parameters are being set, the device applies the last
> > +coalescing parameters received for a virtqueue, regardless of the command
> > used to set the parameters. For example with 2 pairs of virtqueues:
> > +# Command sequence
> > +Each of the following commands sets \field{max_usecs} and
> > \field{max_packets} parameters for virtqueues.
> > +\begin{itemize}
> > +\item Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets coalescing
> > parameters for virtqueue0 and virtqueue2, and, virtqueue1 and virtqueue3
> > retain their previous parameter values.
> > +\item Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} =
> > 0 sets coalescing parameters for virtqueue0, and virtqueue2 retains the values
> > from command1.
> > +\item Command3: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} =
> > 0, the device responds with coalescing parameters of virtqueue0 set by
> > command2.
> > +\item Command4: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} =
> > 1 sets coalescing parameters for virtqueue1, and virtqueue3 retains its previous
> > values.
> > +\item Command5: VIRTIO_NET_CTRL_NOTF_COAL_TX_SET sets coalescing
> > parameters for virtqueue1 and virtqueue3, and overrides the values set by
> > command4.
> > +\item Command6: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} =
> > 1, the device responds with coalescing parameters of virtqueue1 set by
> > command5.
> > +\end{itemize}
> > +
> >  \subparagraph{Operation}\label{sec:Device Types / Network Device / Device
> > Operation / Control Virtqueue / Notifications Coalescing / Operation}
> > 
> >  The device sends a used buffer notification once the notification conditions are
> > met and if the notifications are not suppressed as explained in \ref{sec:Basic
> > Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}.
> > @@ -1549,6 +1612,11 @@ \subsubsection{Control
> > Virtqueue}\label{sec:Device Types / Network Device / Devi
> > 
> >  When the device has \field{max_usecs} = 0 or \field{max_packets} = 0, the
> > notification conditions are met after every packet received/sent.
> > 
> > +When the device receives the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> > +VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands, it saves the values of
> > +coalescing parameters as global values, and the
> > VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command does not change the global
> > values. If the device is reset, the global values will be set to 0.
> > +When a virtqueue is enabled after virtqueue reset, its coalescing parameters
> > are set to global values.
> > +
> >  \subparagraph{RX Example}\label{sec:Device Types / Network Device / Device
> > Operation / Control Virtqueue / Notifications Coalescing / RX Example}
> > 
> >  If, for example:
> > @@ -1585,15 +1653,26 @@ \subsubsection{Control
> > Virtqueue}\label{sec:Device Types / Network Device / Devi
> > 
> >  \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types /
> > Network Device / Device Operation / Control Virtqueue / Notifications
> > Coalescing}
> > 
> > -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver
> > MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
> > +If neither the VIRTIO_NET_F_NOTF_COAL nor the
> > VIRTIO_NET_F_VQ_NOTF_COAL
> > +feature has been negotiated, the driver MUST NOT issue
> > VIRTIO_NET_CTRL_NOTF_COAL commands.
> > +
> I agree to Alvaro's suggestion.
> If VIRTIO_NET_F_NOTF_COAL is not negotiated, the driver must not issue commands A and B.
> 
> If VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated, the driver must not issue commands C and D.


Yea. Though double negatives are annoying.  One way to avoid them is

	The driver MUST negotiate VIRTIO_NET_F_NOTF_COAL before issuing commands A and B.

or
	The driver is REQUIRED to negotiate VIRTIO_NET_F_NOTF_COAL before issuing commands A and B.




> > +A driver MUST ignore the values of coalescing parameters received from the
> > VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command if a device responds with
> > VIRTIO_NET_ERR.
> > 
> >  \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types /
> > Network Device / Device Operation / Control Virtqueue / Notifications
> > Coalescing}
> > 
> > -A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands
> > with VIRTIO_NET_ERR if it was not able to change the parameters.
> > +A device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> > VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if it
> > was not able to change the parameters.
> > +
> > +A device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
> > command with VIRTIO_NET_ERR if it was not able to change the parameters.
> > +
> > +A device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and
> > VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET commands with VIRTIO_NET_ERR if
> > the given virtqueue is disabled.
> > +
> > +A device MUST ignore \field{reserved}.
> > 
> >  A device SHOULD NOT send used buffer notifications to the driver if the
> > notifications are suppressed, even if the notification conditions are met.
> > 
> > -Upon reset, a device MUST initialize all coalescing parameters to 0.
> > +After disabling and re-enabling a virtqueue, the device MUST revert coalescing
> revert to
> > parameters of the virtqueue to the global values.
> > +
> Like others suggested, above can be reworded as,
> 
> After disabling and re-enabling a virtuqueue, the device MUST revert to coalescing parameters to the one configured using VIRTIO_NET_CTRL_NOTF_COAL.

meaning RX/TX I guess. be explicit.

... or 0 if RX/TX was not set?


> > +Upon reset, a device MUST initialize all coalescing parameters to 0 and MUST
> > set the global values to 0.
> > 
> No need to mention global values here. "all coalescing parameters to 0" covers per vq and per group of tx and rx vqs.

Let's wait for new version of Alvaro's patch, rebase on top of that.


> >  \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
> > Types / Network Device / Legacy Interface: Framing Requirements}
> > --
> > 2.19.1.6.gb485710b


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

