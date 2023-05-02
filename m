Return-Path: <virtio-dev-return-12497-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A329BC77B7E
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 11:40:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0B5201462C4
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 11:40:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E6F69986495
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 11:40:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CF6E8986479; Tue,  2 May 2023 11:40:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BD21D986486
	for <virtio-dev@lists.oasis-open.org>; Tue,  2 May 2023 11:40:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: hRrWiSD0NaKqB_7pXTqLeQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683027622; x=1685619622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VTZF9obJCGOF/e+cMKpP4l5n103N4hEa3ahs35zebk=;
        b=IyqwKQ4JZijgMpGmv01qRX3pgY6TxNtAns33XzRsTpqBx1KiARsl9jw2ZuLmPx96Z0
         7OKmcA1CqJnaHU9I1lgb5C4Nj/IK1uydNX4r5a8iQL4bOZNQwFf66ZLmg4Mg+Z99a6/d
         Dg/z4+D6Xv77garg5gArXdve9Wpuc0ekG54KzKsx4CZghU7SN7zawJ6kDZaSfWAxBSA5
         /LETjPNJcYyNRxuGQyVz9SwbaKORuQUusxia9I+/w3LFkFA3aGX5zwVOpaIQyn2vf9qy
         0glf8jX82eJmJmQk/g2/dxCRRjTb2W7oVNwZHk+/UCG1ZEvUKdiFDuC87pG+Xl/LtdDa
         Eelw==
X-Gm-Message-State: AC+VfDwxfiC2myCps0fii2PBiBb2x1qhaUxPUJ0aftg8Q3a6Z9qbr7M6
	6oflvOFe25277CYc29YzqeQE82fhxN85PUxA8w5OgEtVcYKUcpGJRTG1dej2j2c4eN22u1A+83D
	E0C+quUKmH4t9micfMtFZq4icaHvq
X-Received: by 2002:a5d:4e0b:0:b0:304:75b1:4dff with SMTP id p11-20020a5d4e0b000000b0030475b14dffmr11469409wrt.48.1683027622173;
        Tue, 02 May 2023 04:40:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7FDWXPcySSOc3PDCD15dcksl7gXUzypZdR00+4Epp+aKlv5ip+WCUnSAodWqpdy84MGLiOhg==
X-Received: by 2002:a5d:4e0b:0:b0:304:75b1:4dff with SMTP id p11-20020a5d4e0b000000b0030475b14dffmr11469397wrt.48.1683027621887;
        Tue, 02 May 2023 04:40:21 -0700 (PDT)
Date: Tue, 2 May 2023 07:40:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230502073706-mutt-send-email-mst@kernel.org>
References: <20230501224430.485139-1-parav@nvidia.com>
 <20230502033954-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C415A8E662A9F3E9A3F8DC6F9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481C415A8E662A9F3E9A3F8DC6F9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 0/2] admin virtqueue fixes

On Tue, May 02, 2023 at 11:34:10AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, May 2, 2023 3:42 AM
> > 
> > On Tue, May 02, 2023 at 01:44:28AM +0300, Parav Pandit wrote:
> > >
> > > Hi Michael,
> > >
> > > Please review these two small fixes for the admin virtqueue patches.
> > > They are on top of your work of v12 at [1].
> > >
> > > Patch summary:
> > > patch-1 removes PCI transport dependency on deprecated migration bit
> > > patch-2 fixes admin command command data type to be u8 similar to
> > > result
> > >
> > > [1]
> > > https://lore.kernel.org/virtio-comment/cover.1682354275.git.mst@redhat
> > > .com/T/#t
> > 
> > I can take 1/2 since that's just removing text. Taking 2/2 will mean more review
> > time before vote - besides me not really liking that change, are you sure it's
> > worth it?
> > Was going to start voting today but if we are still tweaking command format
> > then I can't ...
> >
> There were 4 editorial fixes without which PDF is not readable for v12 and commit message needs update the AQ usage.
> It needs rebase also.
> And these two changes also.
> 
> Given we have 6+ changes, better to make them and ask for vote after that.
> 
> Vote includes spec and commit message content.
> So please roll v13 addressing above to make things easier to vote.
> 
> You said posting too fast is not good. Now one week has passed, so its fine to repost v13 and ask for the vote.

Yes absolutely. I am still debating with myself whether
the change in result from u8 to le64 means I should wait another
week before vote ...


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

