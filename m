Return-Path: <virtio-dev-return-12756-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5083C77B7D
	for <virtio-dev@archiver.kernel.org>; Thu, 18 May 2023 19:42:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 18E4C1318D3
	for <virtio-dev@archiver.kernel.org>; Thu, 18 May 2023 19:42:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D8931986729
	for <virtio-dev@archiver.kernel.org>; Thu, 18 May 2023 19:42:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B9687983E90; Thu, 18 May 2023 19:42:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A6BD798671B
	for <virtio-dev@lists.oasis-open.org>; Thu, 18 May 2023 19:42:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Tzxcb7RBOIiXLNYBwt33Ig-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684438939; x=1687030939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkMT5T7p5/+HcsQz3l9yGUINmopUARuya177oqeNbLQ=;
        b=JFdX4KrTPbvSr/CqfKfZsy1QBDMafrs6aUyVh1UetUVNI26IySgW6ejEpxz0cAfwsB
         pByPZ9Y/bdQjUQLRCzo/GrGU4kGdq0FyFhbjG6zInKYARLfHi6cpMvcFclz3neyot4xi
         M0SiWpwBTx086tE65RIOMcpS2FpYXXRW9zjN1Jt5whwkp38Or06nasTxa19ogtO0+ujx
         9P7eQUBdUuRpuNv/ygi2lduRl2wRbZkryk6H97TINyD2f+vU+P4X2tUxiPgjWV7hpa4F
         q0QnjlmYbFiIX+VBwdAv6I5a9x1ahEobjd81998XOAeIRaX4WrRtEXcm92mmqhmjpuJj
         mzew==
X-Gm-Message-State: AC+VfDzguBss6JTrfGOjj78qCiTVC2pKM2UlI9Q6ELl6AMxGfhySlzDA
	bz0T5OtS01L1JdjzPzMy1alC7v0wvGi7G9B6Fv72Jmqi5ZYRSDiHLZgfHqul7bVcbZlcOlb7za4
	j6KVkl93TYCAM6dB4rf8f9MSDUila
X-Received: by 2002:a05:6512:4cd:b0:4f2:62aa:986a with SMTP id w13-20020a05651204cd00b004f262aa986amr31157lfq.21.1684438939489;
        Thu, 18 May 2023 12:42:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4JhqtOBBTWjj9qElp/R+SZbG0C26imwsxQsPcXU/9ZaTl7/r1f9d0jjtG6lFHwNW1nsYMdoQ==
X-Received: by 2002:a05:6512:4cd:b0:4f2:62aa:986a with SMTP id w13-20020a05651204cd00b004f262aa986amr31149lfq.21.1684438939066;
        Thu, 18 May 2023 12:42:19 -0700 (PDT)
Date: Thu, 18 May 2023 15:42:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230518153640-mutt-send-email-mst@kernel.org>
References: <20230506000135.628899-1-parav@nvidia.com>
 <20230506000135.628899-2-parav@nvidia.com>
 <20230517013839-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CBB98900B83C4F30164DC7E9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54817CBB98900B83C4F30164DC7E9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands

On Wed, May 17, 2023 at 07:32:33PM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, May 17, 2023 1:45 AM
> > 
> > On Sat, May 06, 2023 at 03:01:34AM +0300, Parav Pandit wrote:
> > > +\begin{lstlisting}
> > > +struct virtio_admin_cmd_lreg_wr_data {
> > > +	u8 offset; /* Starting byte offset of the register(s) to write */
> > > +	u8 register[];
> > > +};
> > > +\end{lstlisting}
> > 
> > So to summarize, I think the main comment here was to have separate
> > commands for access to common versus device config. Just today I thought
> > some more and came up with another reason why this is a good idea: if we ever
> > want legacy MMIO emulation, we can reuse the device config command.
> > 
> MMIO is actually simpler than PCI because all the registers are contiguous regardless of msix.
> So single command with offset can service just fine.

yes but then you need to implement both MMIO and PCI in hardware.
with a flag you can implement legacy MMIO in software on top of
legacy PCI in hardware.

> More below.
> 
> > Jason also feels the common config command can be shared with vq transport
> > effort. We can discuss this, for sure, I guess its putting code in hardware versus
> > in hypervisor, but if there are hardware vendors who strictly want this code in
> > hardware I don't have a big problem with this even if I don't exactly get why.
> > 
> > With this idea all hypervisor has to do is subtract the offset from device config
> > access, sounds like a small price to pay.  
> It is more than the subtraction cost.
> 
> Hypervisor needs to inspect MSI-X enable/disable settings to decide when to issue command #1 vs #3 for the requested offset.

I thought that for now you wanted to ignore MSI-X disable case?
Because if you do care then we need INTx emulation.


> > Does this sound like a reasonable
> > compromize to you?
> 
> Splitting proposed one command to two commands,
> 1. one for accessing legacy common config
> 2. second for accessing legacy device specific config 
> 
> seems fine to me as below.
> 
> So we will have total 5 commands (instead of 3).
> 
> 1. legacy common config read
> 2. legacy common config write
> 
> 3. legacy device config read
> 4. legacy device config write
> 5. query device notification area
> 
> #1 and #3 same cmd signature but different opcode.
> #2 and #4 same cmd signature but different opcode.
> 

Sounds reasonable. Jason?

notification thing needs more thought I feel though.
It feels weirdly bolted on, but I can't put my finger
on what's wrong exactly yet. Will think it over.


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


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

