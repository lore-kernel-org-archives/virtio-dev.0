Return-Path: <virtio-dev-return-12694-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A59C77B7D
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 17:45:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 20528157EFB
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 17:45:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 122119865A6
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 17:45:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 083E898650E; Mon, 15 May 2023 17:45:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E90A7986509
	for <virtio-dev@lists.oasis-open.org>; Mon, 15 May 2023 17:44:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: RofxkBuvMnyojBcHu9fb5w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684172693; x=1686764693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynBZHqtMluZubVdFT50w4/fqWxmotBQ0cyJ5q8QKIiw=;
        b=Y+QIyt72Hcx1s+TIwbs0JHzPPz4pSuySfGwFu9fsCWvDmQ0+atitjRFCDW0psmN0HT
         WohUk0DjaT0ofFBEBtTAVqrA+GEwaR8eKvjsW3jEudDyMPLteVdsZ+fIrqlo1B146yxW
         uE7fnmKDffMWImwoy/sGJBder26Kkq76AQJxnm6bARxvc6fjV9n3MPNpBQ+3b77E9h9I
         kGLkapxVwJBdpnqIh+dyO+S4nHKCT23eDQTiHk6SiWxJaLLLCutwthcrorpT/NLKrqbv
         CSe1W2BYPNDokMgxtUCgWRO6MoRyYjNNXwWkjU8BeHn076VkddrzG8AddghH6JMqXP0p
         Rm2g==
X-Gm-Message-State: AC+VfDxn1lK3skOJ+uW8rNXBVn1EkqPhjYjYxRM3SnAhrbUh2oOpuxwj
	Hc/6iMWRBAbxhXd2h9ceyzB0GcGb7znOoICWV0eMqAQ75cjO0PNKrW4kW36ArhYFi1GQRIxwcyz
	g7hw4tYjRJFyHAYboh1jUY5wzkv1i
X-Received: by 2002:a5d:550c:0:b0:2f6:987f:a0f5 with SMTP id b12-20020a5d550c000000b002f6987fa0f5mr22899484wrv.5.1684172693383;
        Mon, 15 May 2023 10:44:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ58UeE+VJ1UvYzVWCe9tMrELR08hgwYbTjRVaUfUPBJiy3ixLDzbqnyS4p9jLiS9asiIjckkQ==
X-Received: by 2002:a5d:550c:0:b0:2f6:987f:a0f5 with SMTP id b12-20020a5d550c000000b002f6987fa0f5mr22899466wrv.5.1684172693082;
        Mon, 15 May 2023 10:44:53 -0700 (PDT)
Date: Mon, 15 May 2023 13:44:48 -0400
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
Message-ID: <20230515133719-mutt-send-email-mst@kernel.org>
References: <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <43ec1c8d-7d11-2400-3649-1fe366b1e21b@nvidia.com>
 <20230510121417-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
 <PH0PR12MB5481DE0569EC53A862A4D2E9DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <893b6ec0-a74f-69b7-95a3-988f0f9382a8@redhat.com>
 <PH0PR12MB5481CF52380D414AFFBA6A9FDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481CF52380D414AFFBA6A9FDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Mon, May 15, 2023 at 03:49:44PM +0000, Parav Pandit wrote:
> All legacy interface via AQ.
> All modern interface access via PCI or its own transport between driver and device.

I am wondering however about the hypervisor notifications.  Generally
these are the most problematic aspect here I feel.  For example, how
does it interact with VIRTIO_F_NOTIF_CONFIG_DATA?  And generally, having
both guest and host be allowed to access device's BAR seems problematic.
Can we reserve a PF BAR region for these things or is that too
expensive?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

