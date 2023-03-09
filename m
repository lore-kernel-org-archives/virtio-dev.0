Return-Path: <virtio-dev-return-11586-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53083C64EC4
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 19:20:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A6BF526A25
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 19:20:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1EBC39867F9
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 19:20:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8CEF7986701; Thu,  9 Mar 2023 19:20:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8F0CB986700
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Mar 2023 19:19:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: jvsJxmSeMPm5BcdRrqizHg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678389542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sr6VWge0+8ziqeq37Tq4glh+pxVvaVUSkRWc9BV0uuE=;
        b=nXJED3D7lgPtfGxTnej1Af7qxRSP6hN5n6VEXiaKcdlsP7DMiUPTn3B8qz5hnH8UYU
         8ctHxdCLrFS9z7Cg0WHWwEZV0r5UZL8G18/tgm0NiSEcT1XcT/SBJTN2mU3tbFfmRQdZ
         FXnIrNzRYix4ufCFp2M+//0r+7GHQCpjmFMdjXhxNevA7ugm1HuYNn5+A/VM1M5CGtgY
         XW+eFAiPF2HuX7sgAklxf6L0omVkSoBWYclZucsZ3BThhVkheoaak5NPFwOzJVnCq0dC
         lAxw3V7kgN3b8pELCKdlLx7Yc4KhX4ivBksOYnkYX310RctGSlRgHGfqsMJEXXRkplXi
         0LMQ==
X-Gm-Message-State: AO0yUKWY9zzlG6vphJOTUGQjOa2ouCTGEDtNkwYfYs6XaNyc3IZzapio
	ytN3kJUdl5EFJkabFN/DhR4crk2niplGoAPncVyJIHQ1kNjCHgMLVr604B48cACbNxOVTRCvZ7l
	D924Z+mOPFQrN5rwAdgqJU4V8NLF3
X-Received: by 2002:a05:600c:b96:b0:3ea:e554:7811 with SMTP id fl22-20020a05600c0b9600b003eae5547811mr362388wmb.10.1678389541794;
        Thu, 09 Mar 2023 11:19:01 -0800 (PST)
X-Google-Smtp-Source: AK7set/9l3h9xx4/+9IvyLxjlsSaFFIPUSgC13QTQWfZ0QLyKPZVvDOXmt2HOmvgvSah5tTE4X1PzQ==
X-Received: by 2002:a05:600c:b96:b0:3ea:e554:7811 with SMTP id fl22-20020a05600c0b9600b003eae5547811mr362290wmb.10.1678389539528;
        Thu, 09 Mar 2023 11:18:59 -0800 (PST)
Date: Thu, 9 Mar 2023 14:18:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	David Edmondson <david.edmondson@oracle.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230309140313-mutt-send-email-mst@kernel.org>
References: <20230309130521.109102-1-hengqi@linux.alibaba.com>
 <8734c0de-b041-a4ba-9f48-44dc4ceeb513@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <8734c0de-b041-a4ba-9f48-44dc4ceeb513@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v11] virtio-net: support the virtqueue coalescing
 moderation

On Thu, Mar 09, 2023 at 01:53:37PM -0500, Parav Pandit wrote:
> 
> 
> On 3/9/2023 8:05 AM, Heng Qi wrote:
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
> [..]
> >   device-types/net/description.tex | 86 ++++++++++++++++++++++++++++----
> >   1 file changed, 75 insertions(+), 11 deletions(-)
> > 
> > diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> > index e71e33b..c896485 100644
> > --- a/device-types/net/description.tex
> > +++ b/device-types/net/description.tex
> > @@ -83,6 +83,8 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
> >   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
> >       channel.
> > +\item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue notification coalescing.
> > +
> >   \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
> >   \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
> > @@ -139,6 +141,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
> >   \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
> >   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
> >   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> > +\item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
> >   \end{description}
> >   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> > @@ -1505,13 +1508,13 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> >   \paragraph{Notifications Coalescing}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
> > -If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
> > -send control commands for dynamically changing the coalescing parameters.
> > +If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, a driver can send
> Above text had "the driver".
> Better to not change it.

I don't see why it matters. In most other cases we omit it.

> dynamically changing got dropped, better to keep it.

if you keep that you also need to mention parameters
this is what is changing.

I'm ok with the shorter wording - we have a full description
separate the point here is requirement of VIRTIO_NET_F_NOTF_COAL.


> > +commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET
> > +for notification coalescing.
> 
> 
> [..]
> 
> > +\begin{itemize}
> > +\item For commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET, the structure virtio_net_ctrl_coal is write-only for a driver.
> > +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, the structure virtio_net_ctrl_coal_vq is write-only for a driver.
> > +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vqn} and \field{reserved} are write-only
> > +      for a driver, and, the structure virtio_net_ctrl_coal is read-only for the driver.
> for a driver and the structure ..
> drop extra ",".
> 
> > +\end{itemize}
> > +
> > +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
> >   \begin{enumerate}
> > -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and \field{max_packets} parameters for all transmit virtqueues.
> > -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and \field{max_packets} parameters for all receive virtqueues.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: use the structure virtio_net_ctrl_coal to set the \field{max_usecs} and \field{max_packets} parameters for all transmit virtqueues.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: use the structure virtio_net_ctrl_coal to set the \field{max_usecs} and \field{max_packets} parameters for all receive virtqueues.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: use the structure virtio_net_ctrl_coal_vq to set the \field{max_usecs} and \field{max_packets} parameters
> > +                                        for an enabled transmit/receive virtqueue whose number is \field{vqn}.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: use the structure virtio_net_ctrl_coal_vq to get the \field{max_usecs} and \field{max_packets} parameters
> > +                                        for an enabled transmit/receive virtqueue whose number is \field{vqn}.
> >   \end{enumerate}
> > +The device may generate notifications more or less frequently than specified by set commands of the VIRTIO_NET_CTRL_NOTF_COAL class.
> > +
> > +If coalescing parameters are being set, the device applies the last coalescing parameters set for a
> > +virtqueue, regardless of the command used to set the parameters. Use the following command sequence
> > +with 2 pairs of virtqueues as an example:
> > +Each of the following commands sets \field{max_usecs} and \field{max_packets} parameters for virtqueues.
> > +\begin{itemize}
> > +\item Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets coalescing parameters for virtqueue0 and virtqueue2, and, virtqueue1 and virtqueue3 retain their previous parameter values.
> above "and" is confusing. It implies set on vq0,vq2 and vq1, vq3.
> Same for below Command2 as well.
> It also introduces new terms as virtqueue0 and virtqueueN.
> It is better to avoid.
> 
> Rewriting it as below avoids creating new terms and avoids confusion around
> "and".
> 
> Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets coalescing parameters for
> virtqueues having vqn 0 and vqn 2. Virtqueues having vqn 1 and 3 retain
> their previous parameters.
> 
> > +\item Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} = 0 sets coalescing parameters for virtqueue0, and virtqueue2 retains the values from command1.
> Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} sets coalescing
> parameters for the virtuqueue having vqn 0. Virtqueue having vqn 2 retains
> the parameters from command1.
> 
> > +\item Command3: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} = 0, the device responds with coalescing parameters of virtqueue0 set by command2.
> parameters of vqn 0 set by command2.
> 
> > +\item Command4: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} = 1 sets coalescing parameters for virtqueue1, and virtqueue3 retains its previous values.for vqn 1. Virtqueue having vqn 3 retains its previous parameters.
> > +\item Command5: VIRTIO_NET_CTRL_NOTF_COAL_TX_SET sets coalescing parameters for virtqueue1 and virtqueue3, and overrides the values set by command4.
> > +\item Command6: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} = 1, the device responds with coalescing parameters of virtqueue1 set by command5.
> > +\end{itemize}
> > +
> > +Upon disabling and re-enabling the transmit virtqueue, the device will set the coalescing parameters of the virtqueue
> > +to those configured through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or to 0 if the command did not set any TX coalescing parameters.
> > +
> s/if the command/if the driver/

please don't just tell people what to do. provide reasoning.


> > +Upon disabling and re-enabling the receive virtqueue, the device will set the coalescing parameters of the virtqueue
> > +to those configured through the VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command, or to 0 if the command did not set any RX coalescing parameters.
> > +
> s/if the command/if the driver/
> >   \subparagraph{Operation}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / Operation}
> >   The device sends a used buffer notification once the notification conditions are met and if the notifications are not suppressed as explained in \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}.
> > @@ -1585,14 +1632,31 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> >   \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
> > -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
> > +A driver MUST negotiate the VIRTIO_NET_F_NOTF_COAL feature before issuing commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRIO_NET_CTRL_NOTF_COAL_RX_SET.
> > +
> > +A driver MUST negotiate the VIRTIO_NET_F_VQ_NOTF_COAL feature before issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRIO_NET_CTRL_NOTF_COAL_VQ_GET.
> > +
> > +A driver MUST ignore the values of coalescing parameters received from the VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command if a device responds with VIRTIO_NET_ERR.
> >   \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
> > -A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with VIRTIO_NET_ERR if it was not able to change the parameters.
> > +A device MUST ignore \field{reserved}.
> > +
> > +A device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if it was not able to change the parameters.
> > +
> > +A device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with VIRTIO_NET_ERR if it was not able to change the parameters.
> > +
> > +A device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET commands with VIRTIO_NET_ERR if the given virtqueue is disabled.
> > +
> > +After disabling and re-enabling a transmit/receive virtqueue, the device MUST set coalescing parameters of the virtqueue
> > +to those configured using the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET/VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command, or, if the command
> s/if the command/if the driver/
> > +did not configure TX/RX coalescing parameters, to 0.
> 
> Also the sentence structure should be:
> set params to value A configured using method1, else to params B if not
> configured.
> 
> Instead currently it is,
> set params to value A using method1, else not configured to param B.

I don't see anything wrong with the proposed structure, and the
way you want it with if after else is IMHO weird and hard to read.



> So to keep if-else pattern:
> 
> the device MUST set coalescing parameters of the virtqueue to those
> configured using the
> VIRTIO_NET_CTRL_NOTF_COAL_TX_SET/VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command,
> or to 0 if the driver did not configure TX/RX coalescing parameters.
> 
> Just like how you wrote it in the non normative places. :)
> 

maybe fix non-normative too. If  A then B is simple and clear.
B if A is understandable but is harder to read.

> I still think that disable,re-enable doesnt need to be documented twice.
> Keeping it in the conformance section is good enough, specially when the
> text is exact same.

We have this duplication in lots of other places.
But I agree the text should not be the same,
make the non normative shorter and informal,
with short sentences.

E.g.

	If VQ is disabled, its coalescing values reset to what is set
	by VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET
	or if not set then to 0.


> >   A device SHOULD NOT send used buffer notifications to the driver if the notifications are suppressed, even if the notification conditions are met.
> > +The behavior of the device in response to set commands of the VIRTIO_NET_CTRL_NOTF_COAL class is best-effort:
> > +the device MAY generate notifications more or less frequently than specified.
> > +
> >   Upon reset, a device MUST initialize all coalescing parameters to 0.
> >   \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
> 
> Other than above small wordings change, it looks good to me.
> Reviewed-by: Parav Pandit <parav@nvidia.com>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

