Return-Path: <virtio-dev-return-13020-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65BFEB64DC
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:48:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E349AF9396
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:48:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD6479866D6
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:48:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9605C9865BD; Wed, 21 Jun 2023 19:48:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7B63798681B
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Jun 2023 19:48:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: u_XSUG-GPruH1lvfajlURQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376877; x=1689968877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAzVWPKoKfHYATqyItRuQJB63Gh1iJT+55kK9xjNTf8=;
        b=bVy1RSQRbv7gto3D0354QdCl3svXyL1thnrl5tVYoOyac010BH+adhpB58HFI4MrzP
         TNwgbIfVKf4Z0EFQi/bj1p3kJBHgATGGZT6K1zFgZBlldXfZoJPLPEqNSaWRniM5WgBf
         KpHJQW8VZ9eJuuhCyPjergtGng7NoPXBtOMOtaRsvdeq/dD9hHybZJtvWozdttM4ycEt
         9MRtHGsse+9KXmKxKiqXFBmMRunokEhIauMGQkqUCUroIySVGSDMGZnqD6zQNdH1L3D1
         U30dz83jcLj6WqPirWnWgotlwE2tsrT2QMP0hSeoelKEX9uCOMlf6Cby7Z6Qo9F3dsMl
         vBSw==
X-Gm-Message-State: AC+VfDyN25Un+kXovABPd/AOQxMXyIaHl0v4TsaaEWzwDisTxVHbzvaV
	/hogC6YcIfCZXP+N5ekzCBIdinGLrjqzRdMPCcQ7S5qL/W1Ht6s76aM8DaZatEPNmbFRm7Cy3ES
	Q45Lt8FhVemf+OGGVG6fnIycEIhR0
X-Received: by 2002:a17:907:7ba5:b0:973:fd02:a41f with SMTP id ne37-20020a1709077ba500b00973fd02a41fmr17147324ejc.40.1687376877168;
        Wed, 21 Jun 2023 12:47:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7mMUT5k8OZvlgZaEknkSgDMz/TJM0omW83Ujk1MzLgccRPLL5T7lUlGF4v/kUJoeoERoJyQQ==
X-Received: by 2002:a17:907:7ba5:b0:973:fd02:a41f with SMTP id ne37-20020a1709077ba500b00973fd02a41fmr17147308ejc.40.1687376876877;
        Wed, 21 Jun 2023 12:47:56 -0700 (PDT)
Date: Wed, 21 Jun 2023 15:47:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230621154648-mutt-send-email-mst@kernel.org>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
 <20230619122836-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481758B8EE080750D6377C0DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619131115-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D1836A5B9A7B345A20A8DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619133322-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E624E00FC403C9ECFA03DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619135750-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818E61FF6F0B15768829AEDC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54818E61FF6F0B15768829AEDC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v6 4/4] transport-pci: Introduce
 group legacy group member config region access

On Mon, Jun 19, 2023 at 06:12:11PM +0000, Parav Pandit wrote:
> And yes lets please stop calling the transport vq as well, as it is not going to "transport everything".

Good point, this transport is actually virtio over admin commands.
admin transport for short?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

