Return-Path: <virtio-dev-return-12214-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B413C77B61
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 21:08:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C2EAA1FF6F
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 21:08:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BBA3098663C
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 21:08:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AFEF5986601; Thu, 13 Apr 2023 21:08:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9E0DE986600;
	Thu, 13 Apr 2023 21:08:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btXheeSKLaSw5J9S5y+4wmcO7Rm7L7jKFKH2+TYY3G9d4TMYVimkEe8jH/cCEG2t5p8OYFhdNGhnvYHEjd1lhdT/OnrKmgXOMpW1e+VTxW1ViJBl7+tjve93Jkz3kC3Ev4BbDQZS53FYDBTEDMOG0oF14hgIJmeKvZDBwHX+aP+5kJve0TEranS1YsOQGIgUtLSOv/JgEymf2H/bwK8f1C7QFr0F7w8174wvkv+h978WdZ3PcDYxbLB4kRvOlKVfXsvdA+hXO8Dc2KrrB80OONYRGK44+Pr9HxLAzd2IHIlBR/bP3vPh7LWcZUussbfxaSEjxb1gTmUpdg/dDWfgvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9D12f32JJam0MXBEaSWuVlOhammYqWKM5iGzhhfuEQ=;
 b=nOg1FH0B5caYct2yFDnnNUHzxAzGC9OLWZXQVJptGBh/n7gYr4YdWy0MvjUMIfoUoI3PtXHHn0bNVE0A93sHWkPU32sHS/X4QgQt0VfSGq486fjRMEBgDhCIRgJjeF9zVeYpn41DHHQ6gYod3PArdZqlFvi1/j0JOcPb7ILvrTSMIqleQa+gtwGkacCGkD84rGIoECf8W/xpjMz/KSdJeZ+tWyImUEqdQ50qtNWJHuXjrw5d1fU/pEbDufKD9/2CakOaSk+Zs8lzKGQEOjOaaJ3PR8ZTBInKaWQCJpLs6QQ8LfZlUNWXxtqh1OlJfS3PxU9BTpqxLCKobJon78xLDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>, Yan Vugenfirer <yan@daynix.com>
Thread-Topic: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers
Thread-Index:
 AQHZY1tLAUtRpuZtUUOucQPGJlFfkK8flpUAgAQ7nwCAAE6hgIAAAXwAgAAFegCAAAt0AIAALl6AgAEOIwCAAFEgAIAAIPWAgAAcJ4CAASFtgIAABJ4AgAAKJYCAAACFsIAABgyAgAAAT3CAAAYpAIAAAJIAgAAJz4CAAILBcIAAxPiAgAAc1wCAABy4gIAAzAAAgAA85gCAAABI8A==
Date: Thu, 13 Apr 2023 21:08:20 +0000
Message-ID:
 <PH0PR12MB54818B39801152ECBA138E73DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <CACGkMEvYsz1fSPG+fKpRaZ05Ut7ffKwvMPvR8xbRBsXA_6vGQw@mail.gmail.com>
 <PH0PR12MB548137D7A25C99EAA42B4D12DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshW82qztmGw8YJWJ8=QCoRd6cPxQ+ySazxsO_o+U6c4Q@mail.gmail.com>
 <PH0PR12MB548147CF939CB9C2A0586310DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com>
 <PH0PR12MB5481F0CF5A555A6BB2CE856CDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
 <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com>
 <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <f9f01f9d-f6ec-0daa-a11d-c75589dcbe6c@nvidia.com>
 <20230413163216-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230413163216-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB6855:EE_
x-ms-office365-filtering-correlation-id: 4e8b0602-b210-4a97-a22d-08db3c6335dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 K3foVQBl3vwmN/GQaanJmqoXz/le03hUaaoh15LZGgDYFJaQt70x2uUT2ndH3S9i06qbx3jXuNtgVCDo9QHUqmDusZ2XF+8eODvFtyMi45xrgd9pOaSjGZy0827VSBGCNM+2Ah6Om8C+g+AnD5w8iZ2F0HNXz0lP3rfGhoqKUbXChrwbxu1O4ZJdfrmVUTCpfa8k5DyK6nFk9JfnoKDhhqkWJxjoUkA965whdt+O8/53hl7BAbKlyhcq07HcagLSmF8SFaKstuVv7wZdunLhWYc8Un4+N8x/8umifZNiumX7qTtlCWMRCR1LsOQOueFQQ16eep4AUE/7cXSQOOAXw/RyigzNp1aJepjD8QA2iurVWAeyq0Nc7HseEUNB7+s2c3FiNCh26aFb4gglhGSp68nruKLQLKXTVlH19F4sVMXchYF0M7/fSNVfswH5UuhkF93LuaPzDSYCJxsam6LER/qImJeYX4wJSxs0Ba2fHFKRntsCMm1ILq09ccB7w79QDRSkgESEmpiy+O0egNWswSEonH1pxvSsLHYZbwynSmzA17od8lyVn3bE9p+0sjkVeb6Iz58wkv5MJkrK2/SyhgplIj19LupEeYry0Y6ioXZ1vMNFsjzr/sjZF/f5E8AP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199021)(122000001)(478600001)(41300700001)(66446008)(316002)(76116006)(6506007)(38100700002)(66476007)(33656002)(7696005)(9686003)(66556008)(64756008)(86362001)(66946007)(71200400001)(54906003)(26005)(38070700005)(55016003)(186003)(4326008)(6916009)(8676002)(8936002)(5660300002)(52536014)(2906002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AoT6s+V+VcWpD/pS6m/ymXeKskyj2vwnYBpqlbAEgBKxdB36IimodnAL97qj?=
 =?us-ascii?Q?3LY4M5juI4Kqrj4p+Yz7zw4UcX6/j5ZTdWfufZaNHEr433vyOhv0eLHppQ4n?=
 =?us-ascii?Q?Gss7ES0qFLBUTlwSyAq6o+oCkETWAzMIW/CmiJYDB5coObrPjfjhF9aPyBVS?=
 =?us-ascii?Q?btCSe2Yy6RmC24VWXkCgjZJGudR4H39IoCD6yY4yXp5lNoXMjPxBfSnFrnUc?=
 =?us-ascii?Q?7jc0kIz4nIVbg0BKPOZIDk263RvY/35tFbi2fseAWF++W9BEHYyoMHk0IN6m?=
 =?us-ascii?Q?Gh5G0ZTYy4KCSDOIsqdkX2A76L1PeYfYz4WuvISP2Ye+8bz7rRzttlxEioNd?=
 =?us-ascii?Q?L5KUiOBmaBbNupKrm5sWF0fr6Vcw97Z9ESG5h8scq5sDNSMzucu4iQudKUaB?=
 =?us-ascii?Q?ESNmi3LmCYo1Sr8JdKqybEmsX2WcxKxufhVSqAlvtlkqwmb5MvISgmlJYccD?=
 =?us-ascii?Q?NrQxuyio2J+7IS3qAjo4VzHa7iD4VBX/DvYr/9ifFBEu2X5kttDydwb9Y2hD?=
 =?us-ascii?Q?X9nXofWnOeCVZmDRBVT5BjMjv6iwTqxIRB3mGNqzJ20uC4bRzzGpbb/iK3z6?=
 =?us-ascii?Q?NZsR2v4ZF0zbc5E89yCdJ5zHZgtGlWYWGgiycup7DtqtDL/uda9Tnk5IIFCG?=
 =?us-ascii?Q?yFQZd6vLU0VC8sqyDfw15AJYK+IW61pb3K7IDLO5GqUrKKaQsl5Qlrk0skxE?=
 =?us-ascii?Q?pleHmHy+ydkz+o2mKnEpDEQGxhx0pxTyMmYZEwaUbOpCvc/KA+9w9FOM9HfS?=
 =?us-ascii?Q?62TMAxTpBMC9kGTQvI6A1HEXooTTLkza1ysjNvfaMCX2WVqOdRL5SWIxFWNy?=
 =?us-ascii?Q?CwmEGDKxX8wkCAbue6EUHqaFXIIqrWS8QIEx+suV8GSSrNEBPdudAhaI9Cxh?=
 =?us-ascii?Q?z8gr+iSe8rINCd3WbyZQc3KJX843B8Rr9zGrxXqORG/ZOlz0/lTQQwT78Qif?=
 =?us-ascii?Q?jqNqKtbCPFEDi5/JnEBZf91/WCTHA5phmtFPPPTkNX+Vex05rfG65CioUxkS?=
 =?us-ascii?Q?MdfMo1bmsVHNoYhLim2HYrA1bQq3RI0qYUFcQfhOVxhRf+bKbjcjO1QqPHIZ?=
 =?us-ascii?Q?NORoIrbqWB6DsFhVbB86f5P4vXiwf/6P1bFz9gmk5V2a20+LLh0Wp2eNkmuX?=
 =?us-ascii?Q?bcfG1wFMtxKd6ZrBorrSgMKifrbuzWyllzEOvP9JGLnS6H6lkp+qkpVQLGwd?=
 =?us-ascii?Q?1d/BqrC+/fhI1lPRnQR/W/iR3HCjVZBU248ap28y22DbpLAqeSNg9iOft7gp?=
 =?us-ascii?Q?NAJd9QpuaFGvo6EiXkwdydu0kaR2aYLa+sMroWG4A8pqxxcgXN8/5yLeelBZ?=
 =?us-ascii?Q?r+6kckpEvzmodH24NkmTfiFwC9JvSmUcV8pnkFDg/PoLJy4ob1RNjoaE7OQ8?=
 =?us-ascii?Q?IKjNLi4+ODgMg/Dhgm6ej2PokWbYpO3qIWYXwz9f4dAaOv6xo7bFSUuv7xPH?=
 =?us-ascii?Q?YdLr4+koSnSEJu7KdvrIsrdtV9Pko4qFXOxFVAjwFE8qxOuTqdtRpqgsMOtm?=
 =?us-ascii?Q?U7JjOQHvmmHIWrPwdJkQTwW7exb3mFpeazd6+0U/wEb79QOWDQtD0hKWY5wU?=
 =?us-ascii?Q?pLt/diHV2mORJKGRWrI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8b0602-b210-4a97-a22d-08db3c6335dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 21:08:20.6123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8KKvyVr0lgMGpOcmDEPukWGDw6ZI6rO47MN2pKnUg5zsfVu9FGbwwk7G3CwGfYaVYV32ji9hcBEgKXAZ6h+03A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, April 13, 2023 5:02 PM

> This thing ... you move some code to the card and reduce the amount of vi=
rtio
> knowledge in software but do not eliminate it completely.
Sure. Practically there is no knowledge other than transporting like a vxla=
n encapsulating, here its AQ.

> Seems kind of pointless. Minimal hardware changes make more sense to me, =
I'd
> say. Talking about that, what is a minimal hardware change to allow a vdp=
a
> based solution?
> I think that's VIRTIO_NET_F_LEGACY_HEADER, right?

The main requirement/point is that there is virito PCI VF that to be mapped=
 to the guest VM.
Hence, there is no vdpa type of hypervisor layer exists in this use case.

This same VF need to be transitional as the guest kernel may not be known.
hence sometimes vdpa sometime regular 1.x VF is not an option.
Hence for next few years, transitional VF will be plugged in into the guest=
 VM when user is using the PCI VF devices.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

