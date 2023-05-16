Return-Path: <virtio-dev-return-12712-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B5DC77B7F
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 04:18:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C111215386B
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 04:18:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9FC32986579
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 04:18:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 88CA2983DA0; Tue, 16 May 2023 04:18:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 77E34986511
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 May 2023 04:18:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: v17qR0hmOGeMcdZBLsyuLQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684210712; x=1686802712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1i+oFwOq64prLPrePOaDHSqIUpoNmnP3cge/hKF+k4=;
        b=PX93S56O9y3dTEMaQJGUVg70p7O2VUubewyGyTICRRn4j90PyRqbkfbF5+FJsb/up7
         JWMwUtYeFCRrq0kN65wSMq5fJvDlqs3c37EzaPJm0zMoaOKxZzmx6Tryh6m+y3UbWIys
         xknCN1qYEWGu6MLp8ECNZ79a49lnCWiwwTG6hWQ7rmAaX9nptkvkwLPWAOejx9f+ARoS
         3i/52ye3oNmiMwLFue35Rd6VGjSjiBWzFqYstw7BKINL8O5iKACwUC3ehbMYwLtb1XIH
         eEblov0569sSZPekT82cJT7OzN7pARfvKuc/+l4zYxXoTzRNsi8epj81u93/mzzxcaSP
         BnFQ==
X-Gm-Message-State: AC+VfDzyNU/48/Jl0SIwYB1SEyktuIljmHbNzrnKZl4jM57v2R/Cyshf
	ZAut1piaIwdSlWKXBpcKbOgk4JB8sFIjC7ZigjZTU/0Dxk02Z45ks8ux61TJcrabQ8hG5QVWwp0
	Pccjwb1GjDgZhXiMYowhvRaiy5qEW1gnGISui
X-Received: by 2002:adf:e4c7:0:b0:2f1:e162:d48 with SMTP id v7-20020adfe4c7000000b002f1e1620d48mr23531352wrm.47.1684210712340;
        Mon, 15 May 2023 21:18:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ77+QEkomj6eT93cs+VIu+GwePt0pbiTT6LhfM9V85f47S91/dBoHMie2bHbW/Q1drqJqPOgA==
X-Received: by 2002:adf:e4c7:0:b0:2f1:e162:d48 with SMTP id v7-20020adfe4c7000000b002f1e1620d48mr23531344wrm.47.1684210712033;
        Mon, 15 May 2023 21:18:32 -0700 (PDT)
Date: Tue, 16 May 2023 00:18:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230516001359-mutt-send-email-mst@kernel.org>
References: <20230510014534-mutt-send-email-mst@kernel.org>
 <43ec1c8d-7d11-2400-3649-1fe366b1e21b@nvidia.com>
 <20230510121417-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
 <PH0PR12MB5481DE0569EC53A862A4D2E9DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <893b6ec0-a74f-69b7-95a3-988f0f9382a8@redhat.com>
 <PH0PR12MB5481CF52380D414AFFBA6A9FDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <078af8e2-fb10-b33a-6751-374c4fbd09a9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <078af8e2-fb10-b33a-6751-374c4fbd09a9@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Tue, May 16, 2023 at 11:28:04AM +0800, Jason Wang wrote:
> > 
> > > Admin virtqueue doesn't preventing anything from letting IMS go directly to the
> > > device.
> > But there is no aq/cfgq/cmdq defined for the guest, so with current proposal it is prevented.
> 
> 
> It's a choice of the implementation but not spec. Spec doesn't say adminq
> can't be used for guest.

It actually kind of does. adminq controls group members through the
group owner.  owner is not itself a member. For a guest controlling a
member to use adminq you have to also pass the owner to guest.
Possible but not a standard architecture.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

