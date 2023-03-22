Return-Path: <virtio-dev-return-11713-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF79C76195
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:46:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8AC1471CAE
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:46:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7C6E6986475
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:46:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6FBC0986451; Wed, 22 Mar 2023 16:46:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5FB89986452
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Mar 2023 16:46:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: NqCLHncMNCShmxl1_yrkQw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679503612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWCbQtqSiUGMXZ7J6zmGx0AlzMrYOlvHyCrfsZdW9P0=;
        b=6TGPyiXQC8tVk4oqXmfxRNEKXwjRJCNt6hYAQV7vGTUo4I3fsFy9OT4fVydHpM18ld
         6RFzSxSIv95Kml3UUgKUPdvfGgr3cGijJ9qa+18QQJEOPYMJvkzh48QQQLf8j+VJCNTf
         Fvtc3KKyMqY37bjpW/3hAwyqMN9IIp91it2GNX/377xOQD/nyEmjwOtvxITI0GIJkGjM
         OuZvBbPy/h/0cdQdMcti63pzZ/TTq33Z39/UVBFcxJB45Hy4oPVKEGgz9UNbm0yLUB1d
         4Lie1kJF2iIIIIBrZ64NCsr+CScY164Hr6jNKMsqcV8fouUgqO4ksqr70Mfn+Yo7Kmzy
         EaXA==
X-Gm-Message-State: AO0yUKUMKLpfvKUrLBOw4RQyjhR1Skh5vAhP8v2UfKPbpIE0qqJfE+bt
	PiElgZrnMP+LoRikQx/SLjClPfcKshDYw/7PlzjQ0hGo069asIcrad85hvtZTshrKJvxtQuPiVz
	rrCW/ev8xdCMRLywWssLR91UXByGp
X-Received: by 2002:a05:6402:44f:b0:500:4062:99f7 with SMTP id p15-20020a056402044f00b00500406299f7mr7895958edw.32.1679503612506;
        Wed, 22 Mar 2023 09:46:52 -0700 (PDT)
X-Google-Smtp-Source: AK7set/8aeSC70GE5Km1+98GN4Hm30q7v1mWXkIKNtxMCNrqTI+Z2bgKHAJFCTX3omcOxa5caF2oeQ==
X-Received: by 2002:a05:6402:44f:b0:500:4062:99f7 with SMTP id p15-20020a056402044f00b00500406299f7mr7895943edw.32.1679503612278;
        Wed, 22 Mar 2023 09:46:52 -0700 (PDT)
Date: Wed, 22 Mar 2023 12:46:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	David Edmondson <david.edmondson@oracle.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230322124508-mutt-send-email-mst@kernel.org>
References: <20230322125153.128385-1-hengqi@linux.alibaba.com>
 <87sfdwhkxq.fsf@redhat.com>
 <PH0PR12MB5481FCF22C47F2D23E6638E2DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87pm90hhew.fsf@redhat.com>
 <PH0PR12MB5481C1E2C473B2F13D1B8D84DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87jzz8hh1w.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87jzz8hh1w.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v13] virtio-net: support the
 virtqueue coalescing moderation

On Wed, Mar 22, 2023 at 05:44:27PM +0100, Cornelia Huck wrote:
> On Wed, Mar 22 2023, Parav Pandit <parav@nvidia.com> wrote:
> 
> >> From: Cornelia Huck <cohuck@redhat.com>
> >> Sent: Wednesday, March 22, 2023 12:37 PM
> >> 
> >> On Wed, Mar 22 2023, Parav Pandit <parav@nvidia.com> wrote:
> >> 
> >> >> From: Cornelia Huck <cohuck@redhat.com>
> >> >> Sent: Wednesday, March 22, 2023 11:21 AM
> >> >>
> >> >> On Wed, Mar 22 2023, Heng Qi <hengqi@linux.alibaba.com> wrote:
> >> >>
> >> >> > +The driver MUST NOT set \field{vqn} to any value other than an
> >> >> > +enabled
> >> >> transmit or receive virtqueue number.
> >> >>
> >> > Why do you suggest a negative statement here?
> >> > How is it better than,
> >> > The driver MUST set ...
> >> 
> >> So make it
> >> 
> >> "The driver MUST set \field{vqn} to the virtqueue number of an enabled
> >> transmit or receive virtqueue." ?
> >> 
> > Looks good.
> >
> >> > The device will anyway have to check and apply the parameter to the right
> >> virtqueue.
> >> > And if the vq is not enabled or vq is not tx or rx vq, it needs to fail the
> >> command.
> >> 
> >> Well, I think we want to avoid having to add a normative statement for the
> >> device, so we need to be strict with what the driver is allowed to do.
> > Drivers are untrusted entities.
> > device normative statement is needed, it will do the checks anyway where it is applying the config.
> 
> But isn't that implementation specific? I.e. if the driver sends junk,
> the device needs to be able to deal with it in any case.

I agree with Cornelia here. Yes if devices do not want to trust drivers
then they will validate input but what exactly happens then is
currently up to device.
If we want to try and specify devices in all cases of out of spec
input that's a big project, certainly doable but I would rather
not connect it to this, rather boutique, feature.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

