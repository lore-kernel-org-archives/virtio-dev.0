Return-Path: <virtio-dev-return-12727-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496CBC7EE23
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 19:50:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 816E82B12F
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 19:50:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 70FA59865BA
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 19:50:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5DB5B986549; Tue, 16 May 2023 19:50:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 49B49986579;
	Tue, 16 May 2023 19:50:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2q0at1KYetXq6eWX38etkqex8sUUdvQmkcVvu0pG5zi28t2BcW/vDz17+0ciP4kr0tJiMEmYvNKoT/ub5ivq96jXDmu1/HVsCgoDxaK+iA48TK2JtKcV8MncJNz+KBXKViJy4/JWr663vLhZB2x1TnbAw2xl6SNV3En9LlSprlRoYFaCHyjXabA0ANEJ05o5ey19b/yozbI29CzkmsqGf5Le5kTyPmGmZPrRCkaG9qt9mQw4TqqYCGj305KI0hot8UpaB7s8diR55oxNe9T3DgfKxrVLI2I+xOwjyKSRxFcHBDhwQaQZzQRb4kT66S8MWG+LebZmieuk7HzO0Umsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjmGbcaTvYuG3Gzm2dSLhMs4X1OOTcppmS5jjJ12myk=;
 b=INjKePnYD7/vVclZu06QXhU/OdZ8y+Nm2BGE9NOFJKofEB4Nk5if+J+sUCFfBuxicK7Y9zLJMLF8XwfB7olc4/XfSseXuQ3CXprEfl6m39PakrDuUCGrJWHnZF1e2uN7cpEUldli5W47+6gGaeOFw/YxT7UERUesn8iiCbhGczMYNy4NCBoakzaWhKhdfrgg/0SC22ljCC0RmTXiUTJoesbnhXdIOWPWBpAYuPU0pILVveSNa+Iy0r5mmsAUhwROWJYk0aNj60VE4uu/amAy49S4WsaoVcjeUDM3vq6rCB1td1rG1KYBZt2c2y4dhyiyaIIIbdWiW+I4HzO6Jci0QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH] content: Replace guest OS with driver
Thread-Index: AQHZh6LOHXgJrNfl6USbWvfsD1oXE69cZmGAgAAp7wCAABxFgIAAoImw
Date: Tue, 16 May 2023 19:50:48 +0000
Message-ID:
 <PH0PR12MB5481451FE5B75AEA9864C0E1DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230516030139.767838-1-parav@nvidia.com>
 <20230516013842-mutt-send-email-mst@kernel.org> <87lehohefn.fsf@redhat.com>
 <20230516054313-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230516054313-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM6PR12MB4516:EE_
x-ms-office365-filtering-correlation-id: 505b4190-fa5c-430d-368d-08db5646d8c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YPk7fv+81WtcPJMRw8UOMLZ3QgGCg5a9XKE2nKzseqoOogAW3/kY9fOA/T/0R/fYpm1lxM6wkbHU/+VR7Y385ssIsfNRz+R3yqWwo0QAT/1JByPVyPt7+GkjM81kSBWEtLU1aJVMCAxioigLx8zeNLDWNaQARgbPv7yCwuApjkTqIWsTwcUzyVwR11+9d29sChvtEQ82qhr0PjVPIQSpsEf1uZfjXUnuqOFSEf+rm3UyOvytejSRYVbQTcf4+UB8XL/tda8JtVRKXRtcIGWaiZUbuJ+zlzhhzztkVtc1J7wDuXJ1HJlD0LWsaywyjFlzS3JBXFTaXS1K3+77HGzk/i/WKqMWglCdxZn7hGQifjXy5g5qIECOC89h9eq21Ly+q4Dr5eqTkUq2Z6rrVSd0xwRoQQPCubfFDi8zpFCwN3yCjmo6R3k6e/tbYvfIACn1KUyneEPdP7GhKzXhe2nLH36r29A/d6n+JBuuo/69Vt8R8MfhQEspIgtksOt1w/AehIudb2EGUbOWGIunsPcOY1KY7vSEU+YB6ip3EiT/NXYqkfc/FW52zGCt6njnd4AD+Dj1KEarWpfScsOG/Ffh8QPbeJOQolzYwyXbgskoEyjqx8bobBVrFqsxfU1lOO0J
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(33656002)(38070700005)(86362001)(110136005)(316002)(54906003)(76116006)(66946007)(66556008)(64756008)(4326008)(66446008)(478600001)(7696005)(66476007)(55016003)(8936002)(5660300002)(4744005)(2906002)(52536014)(41300700001)(8676002)(71200400001)(122000001)(38100700002)(186003)(6506007)(26005)(9686003)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Cs32mDNhIW1VeoHGE5hQe8qGKazYaNctqto+lnZE4tA6NQeUcgcAOs0V5ptv?=
 =?us-ascii?Q?QsCt2dp6lAF1pQGv1HCxCV0zLGltG3Nm6tyYxnGSGPddexRURD8Xm/FNQaCc?=
 =?us-ascii?Q?BLzy2D9Gdb+Zl4RUVBgdOSHKxGl6y20VEXbkP7cq/j+0Be4+ac3/tIJlOHdp?=
 =?us-ascii?Q?Y1TxKaXmu0qlM1KvultctoeNUCPJms2ewgHksbjAGi9sd30CRRxAqby1dZl3?=
 =?us-ascii?Q?HblvrvnQEu+Xds/8vb6p3dxnmo3zLnWv2mUc8p59tE2ObqeJLrGZHeWXEcl3?=
 =?us-ascii?Q?f4VrhJ6gG4zuMGMYOTZiALywm7lZwGCJi63lstcTXxfju0OfZ5AJNMTW7I5P?=
 =?us-ascii?Q?cDw38GPoR+ZxuuXf5n8O95tzyF9FzvzBzRm1Qo6N+1fNEtw1V/puZatvydPn?=
 =?us-ascii?Q?6cWIVwBBd74dm+Dr0bkO42kV0dI19+9ehrCSS+k+/u+rTjBtQzw3AiJOH/QO?=
 =?us-ascii?Q?CqKSNMwC1e1u2aGE1Qik4WQ38aCZAC8Vkc0+ia5HwTdV8gsjTPVAd98foL1O?=
 =?us-ascii?Q?Pe8wtO7npksdHnUpa7yzaKZHHg7LwYpOx1l3Ztxap6Nc/u5axRRwZTZ3CSK/?=
 =?us-ascii?Q?Wqdxf9+QG1XPeaGYS9VhafDAtUnEcPWD7rWXoyrvqHsXGw8NMph6LPbOXWOq?=
 =?us-ascii?Q?ldJ234dQgsur9BYtzsA6/Hk8mk/cfw6a+xzui3puBKj5oQCvSwh6jYpIUIIA?=
 =?us-ascii?Q?idy6pNG6qs8BHyXY81IPmnbI+qlNK7tE4KJHX9jVxV9QiSpCC+dL3ZiyNy/F?=
 =?us-ascii?Q?ggZ7CE1i9oilqpj8Lx7LYxQJPuxv9IGBKyIuLs0oYi6QhzPzs5uGpg5jhYky?=
 =?us-ascii?Q?4U7fhF5KzN8k/V3frn54PY3QDjPLa/i/Q6C7B/SrrXX/ZA31Z0fbrqTjJAmx?=
 =?us-ascii?Q?pPSnYfpXzBKiOOrrkJqUFDWmx3iJO3+aJTZVT+RzymfXj5t5otFfpEP+1UjV?=
 =?us-ascii?Q?UpxBYwhwocPm9P/oN9qCQAsr5RA58L1tSJvRlOjhSUDvEW7BT83SXpSvadff?=
 =?us-ascii?Q?7RwTEaRHBXqloCyOKHNhb6Hp+jORONeBf40YpDARkQXHh6mWkfiYIPOA3PcW?=
 =?us-ascii?Q?yFyohdjj1sQLB8kfhDu2t/kljfetU23iZ5tYT9tHJ6cJLUrKDegInA817lG+?=
 =?us-ascii?Q?u0kZFUwhPxoFeoxtqM5B95QY12/RMUe2eHAlmkCTN2H39+yPsALRo2uUan1t?=
 =?us-ascii?Q?mBJgJ21ixDe/2fBMDUljlXpPcAP/2b/B62GymiAER7p8zF+u4oo/yA+3/gQ4?=
 =?us-ascii?Q?FaYA1W02xVSn40h5G8i3qR78etIDBpJKory+TPVBwJ1Xh7GvYsFPDy2nuMs/?=
 =?us-ascii?Q?SfZgmiCTnS0CHLJGqS5ruedk7nOa7dEw3Hw0ai+1Kx0qp3M69j6atWYy1e/K?=
 =?us-ascii?Q?ZpYEL3dR5OyC8yEaz/+NYRR5QY3D+j+ha61JH+4hSqFFEhEaFWjYdmBN0WFX?=
 =?us-ascii?Q?6tUiZb9jBcen2CRa8tYUjBLWkLeo2UXGsWnEjmH19nopRKpKRinYwRzHwQTo?=
 =?us-ascii?Q?DneC76W93oFUGfXhnhDiRVE5lOHBK1Bik6siLF2JktN7A1JyS71pFe/64+8t?=
 =?us-ascii?Q?FIPWbu8blSSD8eE1iC4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 505b4190-fa5c-430d-368d-08db5646d8c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 19:50:48.7155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+81fAHiOnThmaMQkancF1z11b8v5ypfhkdlR+naeOPHhhsFGeft/yiraniY3WzzR275EhOG/kj5Y1VYtXWiCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
Subject: [virtio-dev] RE: [PATCH] content: Replace guest OS with driver


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, May 16, 2023 6:05 AM

>=20
> SO I propose:
>=20
> \item[ACKNOWLEDGE (1)] Indicates that a transport driver has found the
>     device and recognized it as a valid virtio device transport.
>=20
> \item[DRIVER (2)] Indicates that a device type specific driver was found
>     and will attempt to attach to the device.
>=20
Above bisection is a implementation specific example of Linux (though valid=
 and widely used one).

The UEFI virtio driver doesn't even have such two drivers.
In some OS variant drivers are merged to single kernel binary.
Does driver only matter with device_driver structure or module binary?...

Driver is largely the software entity that drives the device.
I think we can keep the spec simple enough to not mix these details and jus=
t call it a "driver".

>=20
> BTW somewhat related, I would maybe fix
> device-types/mem/description.tex:change
> not to say "device driver", just "driver" for brevity.
>=20
Ok. will fix.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

