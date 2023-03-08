Return-Path: <virtio-dev-return-11500-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D3DC6FD20
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 05:18:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ED3474435A
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 05:18:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E41A39866EA
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 05:18:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D8D5B983E4E; Wed,  8 Mar 2023 05:18:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C8F109866E2
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 05:18:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: e3KHtkJ1PdK_QVCI65ov_w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678252676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ap9S+Nyc5oM2orJaeHvTOW0EPJF9oeAFATx+nKbuZUw=;
        b=5NOxj3e9+vqaXeXY3qdQUFEUEDaHlvO6mq8cNJyP5CUMc5ZJDNxznsrpIZM6oQEPDU
         VgDskNsOtKncVW6vK5pCsE/gA7lcrHEa9SCNvQWsk3Hs7h9wDh0v3EfcxePibxCTUZcz
         KjoJtL6lT6xkbwcFKUAlaDj1jgcSLC7DEw97gh89IOFTgVOVeJhSwja5PrrMBazTsDwB
         6WJuZWMiOxCE4ffNxwmEOZrOqB5CObLbvHcbxRIr9eeydB2xcolsPI+DePCvvtTk72qb
         74yCqusoePb193CswgzSex441Z+zAj/sp7jwMraDkVEqhv4ROKPsPoEHfynrcFHj1fHq
         /KQQ==
X-Gm-Message-State: AO0yUKUXR1TBnX1cX9IsnOJrt9I11QmdzihCrKQ+yK8g83AcCRVE4g+p
	KoW3vxxlIZRTOFfmyddiVon1vQ9+6Zsx5Zc12QIoLTRwPYFRwLP2OTVUQx7n3GL0kthOm51NhH1
	BSQazIIz6yJBcsFks0FDEFBXfaPB0pe5gsnFoJ88XQb/Y
X-Received: by 2002:a9d:6147:0:b0:690:e27e:503c with SMTP id c7-20020a9d6147000000b00690e27e503cmr5587911otk.4.1678252676500;
        Tue, 07 Mar 2023 21:17:56 -0800 (PST)
X-Google-Smtp-Source: AK7set8eV24yF8nvyfzPg/VlKppg8Di8sg3lHreswKrR6r9oHTLUiwDOWuJuPwhQO0aue758+9/ICHPYoQDLF/vzmxM=
X-Received: by 2002:a9d:6147:0:b0:690:e27e:503c with SMTP id
 c7-20020a9d6147000000b00690e27e503cmr5587895otk.4.1678252676297; Tue, 07 Mar
 2023 21:17:56 -0800 (PST)
MIME-Version: 1.0
References: <20230303083213-mutt-send-email-mst@kernel.org>
 <20230303202133.GA2901137@fedora> <20230305043419-mutt-send-email-mst@kernel.org>
 <20230306000302.GA244754@fedora> <20230305191351-mutt-send-email-mst@kernel.org>
 <20230306110340.GA35392@fedora> <20230306133525-mutt-send-email-mst@kernel.org>
 <ZAbvxj+7lgaI1HkI@nanopsycho> <20230307143911.GC124259@fedora>
 <ZAdTSiVJGSrRIqZ3@nanopsycho> <20230307190347.GA153228@fedora> <PH0PR12MB5481B78E6408C1A7C04FDABFDCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481B78E6408C1A7C04FDABFDCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Mar 2023 13:17:44 +0800
Message-ID: <CACGkMEvn+o1aJnyaWN58gxU6Y-xA3okkWYKcwfmg7ExdhOmv1g@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jiri Pirko <jiri@nvidia.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>, 
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>, 
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>, 
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>, 
	Max Gurtovoy <mgurtovoy@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio] RE: [virtio-comment] Re: [virtio] Re: [PATCH v10 04/10]
 admin: introduce virtio admin virtqueues

On Wed, Mar 8, 2023 at 3:09=E2=80=AFAM Parav Pandit <parav@nvidia.com> wrot=
e:
>
>
>
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> > Sent: Tuesday, March 7, 2023 2:04 PM
>
> > An alternative is unconditional out-of-order completion, where there ar=
e no
> > per-command ordering rules. The driver must wait for a command to compl=
ete
> > if it relies on the results of that command for its next command. I lik=
e this
> > approach because it's less complex in the spec and for device implement=
ers,
> > while the burden on the driver implementer is still reasonable.
> +1.

Note that this is the way current ctrl virtqueue works.

> This has best of both.
> 1. Command ordering knowledge and hence the decision left to the one whic=
h issues them. (driver).
> 2. Ability to execute multiple unrelated commands using a single AQ.
> 3. stateless device in AQ command execution

Does this mean if we want to migrate AQ (not use AQ to migrate), we
need to wait for the AQ command to be completed?

Thanks

>
>
> ---------------------------------------------------------------------
> To unsubscribe from this mail list, you must leave the OASIS TC that
> generates this mail.  Follow this link to all your TCs in OASIS at:
> https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

