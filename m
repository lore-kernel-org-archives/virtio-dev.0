Return-Path: <virtio-dev-return-11715-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49F9C6FD1C
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:50:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3BE461EDC6
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:50:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 32244986462
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:50:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2807B98644E; Wed, 22 Mar 2023 16:50:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 18DE6986451
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Mar 2023 16:50:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: cqf2ktiHMkK8hovrjR698w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679503848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vhqh+BQQBBdbat255WNB0tqjHkcwgGeQB25spk76p0c=;
        b=TeZXppVr0F27xIG4YwjcTajPHpKBoahyh11CjmI4ryWry0Et5T0N9Fumpb+BfZ4ncq
         FD+5gtwht5BhmJ5i/P8im2vgK+Aj+3MfyXR4Y4CWc54/yF6KxQLzWKq5HJ/kqjdEHY5C
         7UI1JXI6R+9qz6XKfEUlgeh7GeA36XNJ15J3af71KLwHWAodYIMZ7hyHKt/SXWevIFVC
         Z8CXqbJuJqYoNjLLrk6hFXc17pS0gaWwbrFjS2JAGQZkzHRylRZFcbq8TcIapubgfTc9
         MqbWN+1TiynD67zOmI4mcx0IWBhldhQvr0ZTyZrWl5G6SfW3Ch35EaSq09Hyc2oRh5it
         Lzyw==
X-Gm-Message-State: AO0yUKUxb/F2Rm+HF8dyU51C8V0tFmisTzLFNY8nJRMuac6AmYGXceR3
	HCH7u5+DkgBXYTHLiJIz/2mLCH5t6HhD7bIZHlmLupu9FVinu3BuBkjjpStX6sMaqQVE2gKtSkJ
	7a1+HuXSqdoOo6LqldcOK4JttD3sK
X-Received: by 2002:a05:6402:2061:b0:4af:6e95:861b with SMTP id bd1-20020a056402206100b004af6e95861bmr2592853edb.2.1679503848114;
        Wed, 22 Mar 2023 09:50:48 -0700 (PDT)
X-Google-Smtp-Source: AK7set81SGKBifejn140arc2c2+DwGhIUA3UbW/6I9BzGIv0ozTbMEdDxAqFgAt55TnqFL+1IYKchw==
X-Received: by 2002:a05:6402:2061:b0:4af:6e95:861b with SMTP id bd1-20020a056402206100b004af6e95861bmr2592836edb.2.1679503847844;
        Wed, 22 Mar 2023 09:50:47 -0700 (PDT)
Date: Wed, 22 Mar 2023 12:50:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	David Edmondson <david.edmondson@oracle.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230322124843-mutt-send-email-mst@kernel.org>
References: <20230322125153.128385-1-hengqi@linux.alibaba.com>
 <87sfdwhkxq.fsf@redhat.com>
 <PH0PR12MB5481FCF22C47F2D23E6638E2DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87pm90hhew.fsf@redhat.com>
 <PH0PR12MB5481C1E2C473B2F13D1B8D84DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87jzz8hh1w.fsf@redhat.com>
 <PH0PR12MB5481F9FF6580D1F8847B9D3BDC869@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481F9FF6580D1F8847B9D3BDC869@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v13] virtio-net: support the
 virtqueue coalescing moderation

On Wed, Mar 22, 2023 at 04:46:36PM +0000, Parav Pandit wrote:
> 
> > From: Cornelia Huck <cohuck@redhat.com>
> > Sent: Wednesday, March 22, 2023 12:44 PM
> > 
> > >> Well, I think we want to avoid having to add a normative statement
> > >> for the device, so we need to be strict with what the driver is allowed to do.
> > > Drivers are untrusted entities.
> > > device normative statement is needed, it will do the checks anyway where it
> > is applying the config.
> > 
> > But isn't that implementation specific? I.e. if the driver sends junk, the device
> > needs to be able to deal with it in any case.
> Not sure which part is implementation specific.
> The device will deal with it and return an error code when supplied qid is invalid (of cvq or of disabled vq).

spec currently defines, generally, how devices behave if driver matches
spec. We do not generally specify what happens if driver is out of spec.
For example it's ok for device to just get wedged until reset.
It's doable to change this but if yes we should do it over the board.
And the benefit, IMHO, is limited.
And doing it just for the coalescing commands would be super weird.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

