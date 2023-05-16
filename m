Return-Path: <virtio-dev-return-12742-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC3AC77B7F
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:54:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0FB772AC4C
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:54:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D7FE99865B2
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:54:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BF3649862F6; Tue, 16 May 2023 21:54:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AC90A9862F8
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 May 2023 21:54:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: yxksY8Y_PneIaB4bfe5bIA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684274068; x=1686866068;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lATTRZQQBhByf8wS6JRmeWxkA0Xs4No+Cl8xkgumfOI=;
        b=S3TSjOGwr02rpq0vGIoS/JTPM0EE5jyQ6vcURlA2QTuqMUnVPYLQAo4arPpOHTyxal
         RCc2d7v5ynXNaU389KRibUVoftP29IeN4q3OhuMYFOpMkiqR2EaUCg3E+w9YeLVR8ECR
         0IgBl3u/FE9fy3W1FXZ+wXN2/9+67XoixMByg0WhdbGijd76HgKCterHogCg2Hxjc1Xo
         3uF1k8HAYMt5aEEswjiTf5onUWD5MGcYXZ7SG6WI/w1ITxsO+uWPJ5YOlcdR56ddinpU
         02jTE5sS41X5q9my+ZQ0qjB0aslhvNKM++L3a1bOvHe8+F24OAqpNWVZ02ZxJba0qx3D
         HrVA==
X-Gm-Message-State: AC+VfDxkmX7IIKbUFxVgMY5BEvoB/cdYpKVQGsyCexc2pEBOJPd+y7ik
	2ajEcN9O4+pKKZgBAEVfXCspCbikky9nHkHXEHJR5QKhYJ+5IaPzQ+mhYny8IO5qtJ+vJnztHlT
	TqOSGvAVTrNbF4eXxIjF1pPIrnDXm
X-Received: by 2002:adf:de8d:0:b0:2f5:3fa1:6226 with SMTP id w13-20020adfde8d000000b002f53fa16226mr29221795wrl.14.1684274068548;
        Tue, 16 May 2023 14:54:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6NLEx4JFguSWOqLREQY1NOwaC+cYRAWpPSYkhTXPnqpKQFeIcUaARc3gGJfjNFJLPZerHSJw==
X-Received: by 2002:adf:de8d:0:b0:2f5:3fa1:6226 with SMTP id w13-20020adfde8d000000b002f53fa16226mr29221786wrl.14.1684274068219;
        Tue, 16 May 2023 14:54:28 -0700 (PDT)
Date: Tue, 16 May 2023 17:54:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230516174852-mutt-send-email-mst@kernel.org>
References: <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
 <PH0PR12MB5481DE0569EC53A862A4D2E9DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <893b6ec0-a74f-69b7-95a3-988f0f9382a8@redhat.com>
 <PH0PR12MB5481CF52380D414AFFBA6A9FDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <078af8e2-fb10-b33a-6751-374c4fbd09a9@redhat.com>
 <PH0PR12MB5481F2BE9C7CB89282E4053DDC799@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsHqD4UUB8PSpSmwYRhvthGzPJ7Up-9xQ+RO8a1N01-rw@mail.gmail.com>
 <PH0PR12MB5481205FAA079FAB1F0E22C2DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230516165853-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481834AB783F39C269176C7DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481834AB783F39C269176C7DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Tue, May 16, 2023 at 09:41:07PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, May 16, 2023 5:09 PM
> 
> > > Possibly one can set. I don’t know if any actual device really supported
> > endianness.
> > > No users have asked for it, even asking explicitly to those non_little_endian
> > users.
> > 
> > For sure, ARM BE does exist and Red Hat supports it because yes, it was
> > requested. 
> Interesting.
> Any vdpa device support this? How is the guest endianness conveyed to this vdpa device?

I don't think, so far.

> And which barrier this ARM uses before issuing notification on legacy?

Would be challenging with hardware, but can work for software virtio
for nested virt I guess?

> > You can not just go by what marketing tells you today we either try
> > to build future proof interfaces or we don't bother at all - by the time these
> > things are in the field everything shifted.
> > 
> Huh.
> One can add the BE support incrementally when the device plans to support it.
> 
> 1.x is already future proof from endianness, so no need to bring endianness for it.
> Only legacy can work in the single platform with hw in wider deployment as David acked.
> So over engineering is avoided by not introducing BE support.
> 
> > > So may be when there is/if a real user, it can be done in future.
> > 
> > The concern is if you assume LE is default, no way to say "I do not support LE".
> > Something like an explicit "SET LE" and "SET BE" commands will automatically
> > allow discovering which endian-ness is supported.
> > 
> This is good suggestion.
> The LE for legacy is assumed because barrier etc cannot work.
> So, avoiding theoretical spec commands here that may not find any user.

maybe at least outlike what happens if some device needs to add BE and
drop LE?


> > > > >
> > > > > > For any case, having a simple and deterministic device design is
> > > > > > always better assuming we've agreed that mediation is a must for
> > > > > > legacy drivers. Using dedicated commands can make sure the
> > > > > > implementation won't need to go with corner cases of legacy.
> > > > > >
> > > > > Corner case handling just moved from the device to hypervisor.
> > > >
> > > > That's not safe, the device should be ready for malicious inputs.
> > > >
> > > With current offset, register, device will be just fine as most implementations
> > have to program control path etc on these registers write/read etc.
> > > So, device will be able to handle them with plain 2 commands.
> > 
> > Except legacy is broken broken broken.  It just does not work for physical
> > devices in a crazy number of ways. How about the weird 48 bit limitation on
> > PAs? Because no one ever will need any more.
> > 
> Legacy is broken and works only in small but widely used platform.
> Hence, it attempts to support it.
> 
> 48-bit PA limitation in virtio?

For queue base, yes. One of the crazy things in virtio ...

> > I have 0 sympathy to this idea of reviving all these bugs then circling back and
> > coming up with weird work arounds.  Please, just build a sane transport and
> > have software deal with bugs as best it can.
> > 
> When I proposed the register interface that adheres to the alignment boundary, you suggested to follow legacy semantics.
> Now when legacy semantics is followed, you go opposite direction of let sw decide it.

Sorry if I was unclear.
I was making a distinction between device specific with arbitrary
alignment, where we should just follow legacy semantics, and
common config where I think sw should decide it.


> Can we agree that alignment, width and offset to be decided by the sw?

For device type specific we can't since spec said we can't :(
For common sure.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

