Return-Path: <virtio-dev-return-13748-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4873CCA5505
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 08:28:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6F7617E991
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 08:28:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4B649986649
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 08:28:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3044B986633; Wed, 13 Sep 2023 08:28:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 21F30986634
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Sep 2023 08:28:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: E_8PS12DNlSxTA992BYWLw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694593681; x=1695198481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQqgAxUPyO+g57feyzMeKAmAJoms/DKgiw2QWgeS50M=;
        b=CqrmS0893j9xxN2zLgeYreRhS3yWg1DJ0j5PeAMyVexFfbB3mAkfRZpEmTN2l/N1M7
         h8MNqAok6+u4nuSsymlaphL7AP1segLMJKeVhqG9743wXOboK1BR/SsU5Wjehb5NDclm
         fTnfRrQuRIz1LZkuoXnc8OJ22jLBzczfgX+etSajkGEUl9930kORnCK2Axt8L4yvUDKo
         AuaZZ4R+/UmEL2zsgSd1a51YxsEf41ROVWwz0+fApcBY3oc43FZXanNUiJSXatk/GUm6
         LbfPITI5HOsC4+7GJvYRDBWq+FCKAsIOCXieBKqqpzIJJSWRSAzHfKZvgX0HYmbWSEu8
         vt6Q==
X-Gm-Message-State: AOJu0YwAf5ARmsOcWzq1Rnl9XamCyT957ZvXBFBREqeKzaML9334PLrO
	5bPkrAEZuoKWEY2Z5OtwvoQRWtt+MXi3hvWDWhw5XwYCwbO/ZM2pO4+F2fOsnOWsEppx0nw+V4a
	rxMCuzO4tToLAGu5tkfo/KHBWbstR
X-Received: by 2002:a19:6707:0:b0:4fb:911b:4e19 with SMTP id b7-20020a196707000000b004fb911b4e19mr1300151lfc.35.1694593680798;
        Wed, 13 Sep 2023 01:28:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEMcfP/0ymeb7vf8h/OuUASEiCzclKteOEwG8dyfw+VidzxlOkOnklYrY5KJg88nc4YZUb7A==
X-Received: by 2002:a19:6707:0:b0:4fb:911b:4e19 with SMTP id b7-20020a196707000000b004fb911b4e19mr1300136lfc.35.1694593680402;
        Wed, 13 Sep 2023 01:28:00 -0700 (PDT)
Date: Wed, 13 Sep 2023 04:27:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Message-ID: <20230913042534-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <eb6c350e-1198-7d83-a553-99c9c8c21edc@intel.com>
 <PH0PR12MB5481760E00AD18DB8BF91636DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ad1dd3a6-7c11-5c6b-b50f-d608ec027dcd@intel.com>
 <PH0PR12MB54819C4A4220712DCD57AD56DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <fff7720f-6019-bd87-b14b-c0bf996f3959@intel.com>
 <PH0PR12MB5481D11A7DF45292103D9290DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEt6=AC4pYEoxNn2dpbLLEKTLj-SYV2eSUAi1ZA1LWR3qg@mail.gmail.com>
 <PH0PR12MB5481E49BFCE50AA8F8373F45DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtor0uDs9xUDXH1ZA3n9Zb9kzP9MAYwN5h6em+39gNfXg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtor0uDs9xUDXH1ZA3n9Zb9kzP9MAYwN5h6em+39gNfXg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

On Wed, Sep 13, 2023 at 12:45:21PM +0800, Jason Wang wrote:
> For example, KVM doesn't use
> hardware to log dirty pages.

It uses a mix of PML, PTE bit and EPT write protection.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

