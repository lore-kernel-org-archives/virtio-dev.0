Return-Path: <virtio-dev-return-13755-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9DEEE0213
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 03:12:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3A8BAEEA13
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 03:12:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 29BB998664F
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 03:12:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 14EA8986639; Thu, 14 Sep 2023 03:12:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0365898663D
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Sep 2023 03:12:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: P2r1fM36MIi4BQqfiJ_fig-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694661125; x=1695265925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9lZ02Uo21jVe/vsNtF2UbT/qTCrQwSJMp2wuhfLO28=;
        b=Sx/J+lRQaumEaeg8KLp3YVylWDxqy7xMpWm5GfzaCryZYTmEbyRbqYQZ8jNWaVSNYR
         TkP+sDP5nIqiaWhdgBXiI1abtx3m8WOLvB2jYjiZQhT/4iaSAR5c8ukfoFQmV/CMCwzx
         FessdDkeY73qgM8/5eXEGDVOxHXUw+WtXR6EquA/QkjYYdMf3cWShH20CYiwuzEoc7wM
         Q9M043woV3s50BV5TYNCcmMsczwGvpuMwwQwEN8JcqUvxpen1lHKLWc4zYNMzS2MMCVp
         mq4ZPLNAtenxkKUyfkpHJcEHF5ceOdTxEXEjeUKmtMiYcz8G+oA3otVVGewkOp47tk0P
         Ws1g==
X-Gm-Message-State: AOJu0YzOLHI006kiA1TbANLtHfVEqYqIvPLG/xFw+D/+YoqZkmu+iNwr
	3EV6DHmhGtZQpqkY4+llRlv4J2ak55QsYeDUxwYz4wijNafLa5U8o3cnSVLkRd0jrHGdDyagvie
	bntQYR+3pDenPFeKP3x54YcqBoqNjITNhzWALX5fu+SBJ
X-Received: by 2002:a05:6512:613:b0:4fb:745e:dd01 with SMTP id b19-20020a056512061300b004fb745edd01mr3479186lfe.45.1694661125805;
        Wed, 13 Sep 2023 20:12:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE63e1UJ3m9H2cyTHvKEzNtdjPfCavTkuVpyM2/ifN0tWL/Jx/36Q4Ul8bZEp/tog46TExg6bdELR9H9GhgVU8=
X-Received: by 2002:a05:6512:613:b0:4fb:745e:dd01 with SMTP id
 b19-20020a056512061300b004fb745edd01mr3479174lfe.45.1694661125584; Wed, 13
 Sep 2023 20:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <eb6c350e-1198-7d83-a553-99c9c8c21edc@intel.com> <PH0PR12MB5481760E00AD18DB8BF91636DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ad1dd3a6-7c11-5c6b-b50f-d608ec027dcd@intel.com> <PH0PR12MB54819C4A4220712DCD57AD56DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <fff7720f-6019-bd87-b14b-c0bf996f3959@intel.com> <PH0PR12MB5481D11A7DF45292103D9290DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEt6=AC4pYEoxNn2dpbLLEKTLj-SYV2eSUAi1ZA1LWR3qg@mail.gmail.com>
 <PH0PR12MB5481E49BFCE50AA8F8373F45DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtor0uDs9xUDXH1ZA3n9Zb9kzP9MAYwN5h6em+39gNfXg@mail.gmail.com> <20230913042534-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230913042534-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Sep 2023 11:11:54 +0800
Message-ID: <CACGkMEv+wNhGMQSc819JFW1n6Ae08QZV1=rDZdZsbDd7ExH3ww@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>, 
	"eperezma@redhat.com" <eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"stefanha@redhat.com" <stefanha@redhat.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement VIRTIO_F_QUEUE_STATE

On Wed, Sep 13, 2023 at 4:28=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Sep 13, 2023 at 12:45:21PM +0800, Jason Wang wrote:
> > For example, KVM doesn't use
> > hardware to log dirty pages.
>
> It uses a mix of PML, PTE bit and EPT write protection.

Well EPT/PML is Intel specific, the minimal requirement is page fault.
The logging is done by software anyhow.

Virtio can choose to go device page fault for sure.

Thanks

>
> --
> MST
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

