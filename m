Return-Path: <virtio-dev-return-12779-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF48C77B73
	for <virtio-dev@archiver.kernel.org>; Mon, 22 May 2023 20:07:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 80429673A7
	for <virtio-dev@archiver.kernel.org>; Mon, 22 May 2023 20:07:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5B8769863C7
	for <virtio-dev@archiver.kernel.org>; Mon, 22 May 2023 20:07:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3BED0986384; Mon, 22 May 2023 20:07:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 219D59863B3
	for <virtio-dev@lists.oasis-open.org>; Mon, 22 May 2023 20:07:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: flJzo_HiNhOESvkED22Oeg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786053; x=1687378053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2701XhzGLjYKgjKoRsVd++QWia6whLpZ/ByhIGai/g=;
        b=Puyvpxsl+RQQ48ouvtg+FnkZFvOCza2AgksBY3Kq/+asb2HMk/JF2T2P5fNaNUvq80
         0rfC939nfWs8+8+vpqGSgP+Tg9gj8Z6sa42DAyY2JupGWrm4ZCDbiOm/7MN1IoQuCDee
         /vllRWkw0IEOKuxA0u9EAZ6+y7aJxwORGozxULzU6geLybTneWHgOD50L/1kH/JKlD8/
         8kkbfumrgjT09SHwAhk4NnsE9kgTwLrhsGtBUQFRUmBG7kh33VgqPsMcR4S4ffBQN42i
         fQqhmidEfEBeGPGDoTPfhMlXUF0VyvDGC60m3RIYKEqLS8Js2ikA35zfXtBY8wljLC7V
         jERw==
X-Gm-Message-State: AC+VfDz+9qSWDeJubLxW3VOK1WgkPKcsHLmviMdw32RdFTQx91zKAeVD
	HnT3tccsp0JmBOHgp1wNe2S2Et3vsy0+NODo1nNdrnQM7543h0XxrJXdiFFgJWoyVxoQTEw1+ZH
	/RUFZ0qAFLiVx4gPoy3SyeMBcSKdJ
X-Received: by 2002:adf:f80a:0:b0:307:820a:490c with SMTP id s10-20020adff80a000000b00307820a490cmr7984644wrp.13.1684786053329;
        Mon, 22 May 2023 13:07:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7kHYYiiRHpf6xIjhGL/slv2w51WDce12VLGVGmN/ul5KZi2zNXBAfBxSQrQL89hIAo0Cvr0Q==
X-Received: by 2002:adf:f80a:0:b0:307:820a:490c with SMTP id s10-20020adff80a000000b00307820a490cmr7984629wrp.13.1684786052962;
        Mon, 22 May 2023 13:07:32 -0700 (PDT)
Date: Mon, 22 May 2023 16:07:28 -0400
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
Message-ID: <20230522154149-mutt-send-email-mst@kernel.org>
References: <20230506000135.628899-2-parav@nvidia.com>
 <20230517013839-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CBB98900B83C4F30164DC7E9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230518153640-mutt-send-email-mst@kernel.org>
 <20230519015520-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AABA8A22DC088B5D7CFDDC7C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521050829-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548161A2D28C387C9AF23B81DC429@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521102050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D83C3287FE7B3A2947CDC429@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54815D83C3287FE7B3A2947CDC429@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands

On Sun, May 21, 2023 at 02:44:03PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Sunday, May 21, 2023 10:33 AM
> 
> > > Yet you initiate same discussion point that we already discussed again after
> > summarizing.
> > > A driver is not attached to two devices.
> > > A driver is attached to a single device.
> > 
> > And that device is the owner no? to send commands?
> >
> Not for legacy registers access as discussed before.

Now I am lost. legacy register access is on top of aq which
sends commands through pf.  how are you going to send
commands without attaching a driver, I don't know.

> > > If (legacy_offset == queue_notify_offset)
> > >    *db = guest_supplied_q_notify_content; else
> > >     virtio_net_send_aq_cmd();
> > >
> > > "simple" is really a subjective term in this context.
> > 
> > yes this is qemu. sure.
> >
> Not limited to QEMU.
> A driver will be able to do this as well.

No, on some OS-es (windows, iokit, more) a single driver can't bind to
many devices without a lot of pain.  If you are mapping VF BAR, this has
to be done by VF driver, and please just avoid pain for everyone by
exposing the necessary info through the VF itself.
A capability seems perfect for this.

An alternative is not to map VF BAR at all, steal space from PF BAR instead.
Guest is not accessing this anyway. So I really do not see why not
from software point of view. There's a hardware reason? Could you
talk to hardware guys about this? You objected to AQ too then
hardware guys told you it is not a big deal.


> > So we have legacy emulation send commands to VF or to PF.  Okay. But let us
> > avoid the need for VF driver to send commands to PF to initialize.
> > Just get all information it needs from VF itself.
> > 
> > 
> > Maybe it's a good idea to reuse existing notification capability, or maybe a new
> > one, but let's avoid making VF driver depend on PF commands.
> >
> We agreed in v1 on Jason's suggestion to have the AQ command and yet
> you and Jason hinder this in v2 with this exact repeated question.
> Lets please avoid this and move forward.

How was I supposed to raise this issue on v1 if it was not there?
Stop arguing in circles and things will move forward.

If we have trouble converging on the notification thing, how about we
make progress without it for now?  Merge a slow version that sends kicks
through aq, then work on the best way to make notifications faster,
separately.


> > > We have already these design choices and tradeoff in v0 and v1, it doesn't fit
> > the requirements.
> > 
> 
> > So, I am saying one model is small driver for VF and a big one for PF.
> > And to keep the VF driver simple, it should get information simply from config
> > space capability.
> 
> VF driver is small that does usual vfio passthrough work.
> PF driver implement AQ for variety of use cases that we listed in the AQ cover letter.
> VF driver implements 5 AQ commands that you suggested to split from 2 to 4.

VF(member) driver can't implement AQ commands at all. They are sent to
PF(owner) thus by PF(owner) driver.  In virt configs, VMM can trap
legacy access and talk to owner driver to send them.  It can also talk
to member driver to send notifications.  You can I guess have VMM get
member BAR offsets from owner and pass them to member for mapping. This
raises all kind of questions of trust.
If you can map BAR from PF that would be simplest, VMM then only pokes
at PF and not VF. If not then we really should expose this info
n the VF if at all possible.





-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

