Return-Path: <virtio-dev-return-11401-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2647C678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:35:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4601C2AEF6
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:35:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 179D0986788
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:35:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 044E0984091; Thu,  2 Mar 2023 23:35:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 513F99866AC
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 23:34:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 5d8AEIT3PQa5yiy0E6QTTA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677800076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+J6nIVeXnpRCXDBXFb2EahhXZtF2x0BlDF7aEJgdTg=;
        b=yWVPfzTkKkrAHWyZ3lqXmHhDLDE7OXVwQrZ1S/NcureHO4mfGY6qyu487d/W6FeFmx
         Vh2Q/0smoO7PMiMQwKFNx3jQeeK8CE15UR+8LNdlO5cYZ8JCO2Jcd8uOTqmGY8LGYfLw
         VgjgYK35A4ZJBUArtO5nkONa+4KCx/jTd/OA4L51HPCbGCuAO4Ogpacmp7W9S49oQ/0L
         CoybSZE0BII7fVV3gAp0vSX5j0pzhgumZFgYewZq2dx/nTBF9G5x7IZmw2QUCe/GwvGn
         +WZ3lva0qNzSGuBK01ktt73hXhYPwlEKOcEfhtRlcCbam3wyOxlTS1UnNdPU1M0ssn3H
         cs8A==
X-Gm-Message-State: AO0yUKXXbEzNu64A1abptqreJZMpjsTYj38shB9htBo/aN001uWBVxjf
	8JXa+1U+kIwzTKaHvTPqANiuaC4plzx/VR7L5LZ230DysU4dQ8AUgEFMCRscAch+0ECZZ1V0J3E
	/UtJekuaDOjo3ELy+AGmYa2Y1shbclNJsOw==
X-Received: by 2002:a5d:5011:0:b0:2c7:a3c:5b90 with SMTP id e17-20020a5d5011000000b002c70a3c5b90mr45749wrt.9.1677800076562;
        Thu, 02 Mar 2023 15:34:36 -0800 (PST)
X-Google-Smtp-Source: AK7set+ENda91ImCD4C4lo0nWx+aB3979nNGDd+NilwRBwIRiPCu8ome9G9uXAeR31oUBIunjbFY/g==
X-Received: by 2002:a5d:5011:0:b0:2c7:a3c:5b90 with SMTP id e17-20020a5d5011000000b002c70a3c5b90mr45732wrt.9.1677800076151;
        Thu, 02 Mar 2023 15:34:36 -0800 (PST)
Date: Thu, 2 Mar 2023 18:34:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	David Edmondson <david.edmondson@oracle.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>
Message-ID: <20230302183149-mutt-send-email-mst@kernel.org>
References: <20230301141027.59500-1-hengqi@linux.alibaba.com>
 <PH0PR12MB548192A8443A7F30A70CFE80DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548192A8443A7F30A70CFE80DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10] virtio-net: support the virtqueue coalescing
 moderation

On Thu, Mar 02, 2023 at 02:48:44PM +0000, Parav Pandit wrote:
> 
> 
> > From: Heng Qi <hengqi@linux.alibaba.com>
> > Sent: Wednesday, March 1, 2023 9:10 AM
> 
> > Currently, coalescing parameters are grouped for all transmit and receive
> > virtqueues. This patch supports setting or getting the parameters for a specified
> > virtqueue, and a typical application of this function is netdim[1].
> > 
> > When the traffic between virtqueues is unbalanced, for example, one
> > virtqueue is busy and another virtqueue is idle, then it will be very useful to
> > control coalescing parameters at the virtqueue granularity.
> > 
> 
> [..]
> > +Read/Write attributes for coalescing parameters:
> > +\begin{itemize}
> > +\item For commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
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
> > +
> Maybe I missed the conversation while I was sick.
> I remember we discussed that instead of mentioning each individual field, better to describe the whole structure being read-only or write-only.

we can't, for GET part is RO part is WO.

> > +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
> >  \begin{enumerate}
> > -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and
> > \field{max_packets} parameters for all transmit virtqueues.
> > -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and
> > \field{max_packets} parameters for all receive virtqueues.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: use the structure
> > virtio_net_ctrl_coal to set the \field{max_usecs} and \field{max_packets}
> > parameters for all transmit virtqueues.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: use the structure
> > virtio_net_ctrl_coal to set the \field{max_usecs} and \field{max_packets}
> > parameters for all receive virtqueues.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: use the structure
> > virtio_net_ctrl_coal_vq to set the \field{max_usecs} and \field{max_packets}
> > parameters
> > +                                        for an enabled transmit/receive virtqueue whose
> > number is \field{vqn}.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: use the structure
> > virtio_net_ctrl_coal_vq to get the \field{max_usecs} and \field{max_packets}
> > parameters
> > +                                        for an enabled transmit/receive virtqueue whose
> > number is \field{vqn}.
> >  \end{enumerate}
> > 
> > +\begin{note}
> > +The behavior of the device in response to these commands is best-effort:
> > +the device may generate notifications more or less frequently than specified.
> > +\end{note}
> > +
> Michael,
> Why this should be a note? Shouldn't it be a normative line in the device requirements?

the second part with
"may" should be upper case and used in a normative section, true.
We can also have a note with the best-effort part, just avoid "may".

> > +If coalescing parameters are being set, the device applies the last
> > +coalescing parameters received for a virtqueue, regardless of the
> s/received/set to match the if condition wording and regardless sentence after.
> 
> > +command used to set the parameters. Use the following command sequence
> > with 2 pairs of virtqueues as an example:
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
> > +Upon disabling and re-enabling the transmit virtqueue, the device will
> > +set the coalescing parameters of the virtqueue to those configured through
> > the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or to 0 if the command
> > did not set any TX coalescing parameters.
> > +
> > +Upon disabling and re-enabling the receive virtqueue, the device will
> > +set the coalescing parameters of the virtqueue to those configured through
> > the VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command, or to 0 if the command
> > did not set any RX coalescing parameters.
> > +
> Looks good, however you have well covered in the device normative statements.
> So possibly it can be removed from here.

I think it's ok - more readable.

> >  \subparagraph{Operation}\label{sec:Device Types / Network Device / Device
> > Operation / Control Virtqueue / Notifications Coalescing / Operation}
> > 
> >  The device sends a used buffer notification once the notification conditions are
> > met and if the notifications are not suppressed as explained in \ref{sec:Basic
> > Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}.
> > @@ -1585,11 +1637,25 @@ \subsubsection{Control
> > Virtqueue}\label{sec:Device Types / Network Device / Devi
> > 
> >  \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types /
> > Network Device / Device Operation / Control Virtqueue / Notifications
> > Coalescing}
> > 
> > -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver
> > MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
> > +A driver MUST negotiate the VIRTIO_NET_F_NOTF_COAL feature before
> > issuing commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> > VIRIO_NET_CTRL_NOTF_COAL_RX_SET.
> > +
> > +A driver MUST negotiate the VIRTIO_NET_F_VQ_NOTF_COAL feature before
> > issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and
> > VIRIO_NET_CTRL_NOTF_COAL_VQ_GET.
> > +
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
> > +A device MUST ignore \field{reserved}.
> > +
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
> > +After disabling and re-enabling a transmit/receive virtqueue, the
> > +device MUST set coalescing parameters of the virtqueue to those
> > +configured using the
> > VIRTIO_NET_CTRL_NOTF_COAL_TX_SET/VIRTIO_NET_CTRL_NOTF_COAL_RX_S
> > ET command, or, if the command did not configure TX/RX coalescing
> > parameters, to 0.
> > 
> >  A device SHOULD NOT send used buffer notifications to the driver if the
> > notifications are suppressed, even if the notification conditions are met.
> > 
> > --
> > 2.19.1.6.gb485710b
> 
> Rest looks good to me.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

