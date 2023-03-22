Return-Path: <virtio-dev-return-11701-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D08C6FD1D
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 02:45:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EA72394EE3
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 02:45:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E3B41986451
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 02:45:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D85EB9860C4; Wed, 22 Mar 2023 02:45:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C1E8998643D;
	Wed, 22 Mar 2023 02:45:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERc6AasDXxTx+f1Gz2PnU8RWuh0krfRLd4mxx4anEBr33FUAgCnhO/V9zazG64c9+tNEfRL9GkliJ0nukudvjQos86UTs+ETmySItNyXH7wjEeXdTeA2K/Nm1G5/rXrwtYE0+fjLKFJTkhCrvyfXoeZNp1tdCgjf+UX4eB+2JE4maDqx1OtH14csljxOlzqHI8r67Tps1Cbw3WA+DXsWrN5zs07pam7uPf0aoz7h5xcHjdbJAyr+6PQaweYz0TRWjvItQfc4ZBKXFopplGSm5cDG0i728DPuy+4nBreBEfiWcVX9rYTpiaYvSrejqB/TYMS9Wi0mZjKazVLqeXi1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOnuFbzRUHPsiqZtDvOaed6oSwovT+liPzaxt0a4KME=;
 b=F/ysW3wZNlcGTaH05BbdYhHReESrTAscFwJ41jDDBxchJDULRfvULjH4f4/SwMjq5bA+5QRyT7ANPzxVikKJJHFU1ZOPR80ezamKt+6ucGAT/Zn/SZyvsex/iViHyDkPtAc12qO9zWejWcnRRctDR9bXP43DLgVuCLp/BHXRikhyBcS1QXTGaZUJy366oRJj68H0tdl2ikgRHEhMaD3LTLiEinvVveQ2gkptCI5SbBzhg2+hYPgi0+o/HhMgZZGP7dg4fXLrWc4W2bTM9dO/kkSpNLKuQIlyBuvRm4REvz3JKU0ru+2Whx9nvNjeHni2pvgEqaX0Gf2szBQCvYdROQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v3 6/8] transport-ccw: Refer to the vq by its number
Thread-Index: AQHZXEBgSCtJtVXRPkiej6PDk45tcq8FzniAgABHowA=
Date: Wed, 22 Mar 2023 02:45:00 +0000
Message-ID:
 <PH0PR12MB5481D1A39CACD02A2BBD4721DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230321215834.225856-1-parav@nvidia.com>
 <20230321215834.225856-7-parav@nvidia.com>
 <20230321181704-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230321181704-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB6629:EE_
x-ms-office365-filtering-correlation-id: 77a1ba50-0307-4220-adac-08db2a7f6e5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mJdBKUHkaqA2b6QkrpnlBOKfUJjY2qSPPab1gfZh9r6bYBhm+Zs9FrMkWUt5LV54ixnklTYnEq+GQidv6Gn4WzKuVN4OI1DImNkSmBgFXAddJOpaRBsxQH1kgY1Vh9MEHPukbWUqhfOxkpsYRqIUdgzKJMjXiAnbPWOwXWBLBA9sNhj9tT8QJD1WZQgDvKQ7d1RlcYagM+RoBDAnq9YxpWT5J0jich6WdeA/i6rSMoU4/Z/jjPV/DBBzY2iNsh8dBD29ZOVEf+jYLyFKp5Y32UaGuFvTG412vpQwoho+6LR1TQ7PyBUjcH6uuH4qSQdcq0y//jgd0kh31CpkgA//UyIPGiM93wvE9QfWEDIUTzv2HfBrr5CrrMueWL9hurqOY/EVMZW4sdFHm8GjfiiLJ6EVd2wZN8Wswx44e3JnSek3NqqF0Q1WTyu0ypTBbVyGoKfpHRoQMQoC76E1wItghGDFcM+GIp3xGcibwkS99WwMeaa+FnegUia0HLv1AsfxErMjTQwyLgOiPYgGrag7cxsoEFoznTm6q3AjmyuCLDIxxvH3cEe0KdZvkh3RbcRn3elY2XZNbcvGANeJc6ydkd86Kn0fHXOpwSXADkZHbu09trz5/8VoUyZN71ku3RAO/iPyMeV5eH5O6yZIQha71s5ZTNhz3ZCsJX4EBdVEM0L12JEDxIRRd7UAESwx5zejpVuPWPfMGNdUg5CM+2BV5A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199018)(2906002)(6506007)(5660300002)(55016003)(9686003)(8936002)(4744005)(52536014)(26005)(41300700001)(86362001)(186003)(107886003)(7696005)(316002)(33656002)(54906003)(66556008)(478600001)(66446008)(38070700005)(66476007)(76116006)(64756008)(71200400001)(122000001)(66946007)(4326008)(38100700002)(8676002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?peq1kz16Dzc2olKhPVlzlPuB5HiG0EKtvpCa7ZgaRl846g2osx6jAA6qtUgb?=
 =?us-ascii?Q?tcKc8PDCk80TYBuvaG618cAD7O1MgxUUFopjkb37LmoatnYISQvxja0gRnle?=
 =?us-ascii?Q?in8rLZWONI/zViGue9UHCBOQmZC702ovlW51NhlwDz07EXd1vIvYziyP6diU?=
 =?us-ascii?Q?7gtJu7G952mcDJh875gkTQnjFNH7WeOpDZKew3TCt9SxGN/gHEDNtQu3vwcq?=
 =?us-ascii?Q?8UifCQ2wrXGy8j8bOM+2w3No5aeBTcX3bbY2AtnL6hF2NiS4gJRC8CnptR0B?=
 =?us-ascii?Q?A9ICmVFfmM8mavAcSeLHefJ8Ip48uFq3GEdRST8PxJCbPXic41VAGNXQzXm7?=
 =?us-ascii?Q?dKskll6zbzGXPhUF+aKVdSB5mZyxkGC2r603wRgQX+I3AfL+rXTXboZLiOB4?=
 =?us-ascii?Q?jk02xdM9wC6yAZW44QbvsfnnVWf4NvvFBtwXEWQJs/JO7NwS/R9ou0Uf47Wx?=
 =?us-ascii?Q?VR+zVcjDMqpjkP46vqXlx48y+zK8leZpPheKlyPWNmnA0NSRUMOiHlKUy0fH?=
 =?us-ascii?Q?8iUW0DkY1eHqq/5bGYF9bxqIhi6oZH8FnAXPZOGRvDew1K2GYudc/+sgwqbD?=
 =?us-ascii?Q?iH1+BjuGDUCSEIQ+z+hnmDkiP/S2qtTqOa4mNUr2njkqgm7REa+nhrWw8m1T?=
 =?us-ascii?Q?qYTG5eOHYG1MGZbxTPscpnpdg2gUadiuFKY4HoEHPlzyQLcGF9u0PswJNpmg?=
 =?us-ascii?Q?DApo2Yzx2YP0/yAamHupNLFEWemioLW4H5xYSAQNvii6uRB3J10RDy7owCOE?=
 =?us-ascii?Q?yjmOzvNk/mqjRsGa1yigtrfDwgG5/r1in8/2D1QhvX2Mc2FZOMaMnQ3AZvVE?=
 =?us-ascii?Q?82LZHNftunAfhZwxeWW0Zm9zxAxbgSUF6GfQoQR70n/KpkeqthYLqshdQTVJ?=
 =?us-ascii?Q?gL1ouGsD3/oR2VcfX9FMEZYpjjttLGLoWmYSv81ISC5MKEP2v9rAHg00DUOr?=
 =?us-ascii?Q?L5wD31bxyILQxMNqF7pe6oAUVp1t8c/8Ot+WZVk1NWW9ZaS1jbtzLcTdN9Nj?=
 =?us-ascii?Q?SOWJUwEwZ9iJSHGvJTwSzM/fWkcDHYZIxRK4Ccbv7y7W/rohzzypBREGzz6e?=
 =?us-ascii?Q?+h3osyFy082nHv42K+3330aTo56Jm/299jgiCZzHbeuPn12WDW0l/xm1L8aI?=
 =?us-ascii?Q?pcbHwlszHVcZ/SqrRDffM0BcJ9vh3iMdFPL7zYdUXeBrFazcceYPs9adKMbE?=
 =?us-ascii?Q?qoFL3aHQs2qeAWLPMolaz1VYmjyQFSMLkUZFOzARhP6xzY8nmgl75E/z7zVG?=
 =?us-ascii?Q?NHXP5E0/TlE2PsnemQwKB4egsgWZQdwsr+S/N92yd0S1fA0It9vpFLxx1yxH?=
 =?us-ascii?Q?8Agsy86cxfhzduikBoolWE3atW0c6zFI7xdywrStVu1Vp299oAXerQjHPriM?=
 =?us-ascii?Q?sXDFcJVnsQxRrbyX/RNl1khIOrg8pVSGhbVB0C4egyBFO1K8yNsyVUAHo6Bm?=
 =?us-ascii?Q?cTaSPSI31tT8m7u6rcVteWANI8A8JmqSQy5ur8Y0zLjDN9TJp4QnaWGNtV4B?=
 =?us-ascii?Q?oGhet71mwyWWjFqHiphXbjcHAW9TZRlVA6vizo/a7Me3HqThN43ZXXTNVFlV?=
 =?us-ascii?Q?+SxrhjM0sfhxhnYnj4Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a1ba50-0307-4220-adac-08db2a7f6e5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 02:45:00.3394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KGy0chb6pcUCJZurdmvHPSFPbLSZ5lT+9ptD21iZSC5CGJc431o0GMB5xyRdgn2yZgy+nIOodKQwZT5KzocFSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629
Subject: [virtio-dev] RE: [PATCH v3 6/8] transport-ccw: Refer to the vq by its number


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, March 21, 2023 6:22 PM

> > +\begin{note}
> > +\field{queue_select} was previously named as index.
>=20
> sounds a bit strange, and \field{} is missing. If you insist I'd say
> 	in previous versions of this specification,
> 	field{queue_select} was also called queue \field{index}
>=20
The field is missing because field index is no longer there.
>=20
> e.g. in blk we have this:
>   In the legacy interface, VIRTIO_BLK_F_FLUSH was also
>   called VIRTIO_BLK_F_WCE.
>=20
>=20
> but I really feel this misses the point, the compat is needed
> in the struct definition, not split out after usage
> is described. This is why I proposed just making this a comment in the
> struct. Why not?
>=20
Sure comment is good to me too.
In v0 you specifically asked to add note with example.
You said "like "Note: this was previously known as QueueNumMax""
It is hard to guess to write a comment when you mean "Note". :)

I will change to comment format.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

