Return-Path: <virtio-dev-return-13473-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E028C001DF
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 14:09:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CE470C6113
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 14:09:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD5AF98680A
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 14:09:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 876999866DE; Fri,  4 Aug 2023 14:09:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 758B59866DF
	for <virtio-dev@lists.oasis-open.org>; Fri,  4 Aug 2023 14:09:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: PRQ4FHJqPLimuNe3d9w_kQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691158038; x=1691762838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBtqQ94NA8ntaFqIdglJoTAlV0bEhfHYwalP0i8yaok=;
        b=GmSNXniPxt3IKGp2me9qMZuujPNEzH5bRvLUPmREjUTcxq7HjGsjitxtYEJzCc1GV4
         e1j5d3XVRgUBJbTYPCljR/sK45GEioM+4p2teCdDQ3KyE6myxUPmpqS5WlVrGaHcB+l6
         Pg2w94SSKhbPnZlkkpdbYNbmaQ55AVwFy1KCinYQvoBs/P5ZsnQlrH3a49O1gWalmTDz
         luzR6BPEA4oPnELuwd1rWhZkhEJismVZrovDQVFn5fbWR2ktM2p/MWSDzgLxHWCUggG+
         xmVxmd13Xkrq5uyErzZsCi1CLWJWOWmEWzAvUSVyXLWP+SshMdKA4ZyG8tttxajy56g/
         aXHA==
X-Gm-Message-State: AOJu0YxRwxwhyETSVXcUMOjid9mixdDuBsiitM5YSJVE8vhUzhYNyfxs
	FGWflKXKmflyVn0qxAFbnhiKKglWMmPaoBQlocTG9CqrE/15/Ey59dJblDXCclHvKiR0XwNZ9mf
	voG7wjejlBepkdBg07bIvnupGUL+z
X-Received: by 2002:a2e:964e:0:b0:2b7:a72:103b with SMTP id z14-20020a2e964e000000b002b70a72103bmr1587222ljh.53.1691158038621;
        Fri, 04 Aug 2023 07:07:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV73DBG/wiv9x5Tq6EEYaF32Xovvck29p7h89Q8dzXeN9QNwt6vyZHEgQynrbShW1X8yyA8A==
X-Received: by 2002:a2e:964e:0:b0:2b7:a72:103b with SMTP id z14-20020a2e964e000000b002b70a72103bmr1587201ljh.53.1691158038166;
        Fri, 04 Aug 2023 07:07:18 -0700 (PDT)
Date: Fri, 4 Aug 2023 10:07:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Message-ID: <20230804095255-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481E104793F9E68E1DC95CADC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062877.0013635-8-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481C3CE21016385BF7D6FF0DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691129914.3255427-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481F521F146049E5E483B7DDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691132049.7182267-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481BE16AC810CD3A6D64832DC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691135097.4908528-3-xuanzhuo@linux.alibaba.com>
 <20230804053958-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548152A5677F0508A62587AFDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548152A5677F0508A62587AFDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC] virtio-net:
 support access and control the member devices

On Fri, Aug 04, 2023 at 12:49:04PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Friday, August 4, 2023 4:03 PM
> 
> > > >
> > > > At this point to have port for owner device requires creating a dedicated
> > switching object, to be located sometimes side by side inside the owner,
> > sometimes outside.
> > > > All of these cases to be crafted, please rethink if this is _really_ needed as
> > virtio object or not.
> > >
> 
> > >
> > > YES.
> > >
> > > We can hear others.
> > >
> > > @Jason @Michael
> > >
> > >
> > > Thanks
> > 
> > 
> > This is so abstract, hard to have any position as I'm not sure what we are
> > discussing. If some virtio devices have an integrated switch then ability to
> > control the switch through virtio seems useful.
> >
> True, for us, at this point we do not have plan to expose virtio switch device because users are not blocked on it.

If someone does though I see no reason not to - we have a variety
of devices, switch would be just another one. The motivation would
be the usual one for virtio - so there's one generic driver.

> > Re:queues - it's not by chance that we have multiple admin queues.
> > So driver can dedicate one queue to filtering commands if that's felt to be
> > important.
> > 
> Admin queue currently do not send non admin command of the device.
> Would you propose admin queue for something else also for rtc or console or cryto device and indicate its role so device can understand what is coming to it.

Well, I guess this switch has group members as its "ports" so
maybe that makes it like an admin command. Again it's all up
in the air too much to be able to judge.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

