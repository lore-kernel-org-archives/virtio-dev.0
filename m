Return-Path: <virtio-dev-return-13468-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01D2C04A94
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 07:26:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F312D192307
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 07:26:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E3B6998670C
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 07:26:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CE3F09866DE; Fri,  4 Aug 2023 07:26:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B9B149866DF;
	Fri,  4 Aug 2023 07:26:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyoNZXu+/mjlj4OHTOXkjcH+gCnxDHythuFIrt5zJE/9o2V93UfoqOw9/JxinohWIB9nKqJLV5FuuKLFlLPnSJxYubBD/JLI7iN3XHPS/BoARK2FlLrYnWBu57PVH+TPYUxrRZtYrez0Y+1+yWfl46ltw/B3zXdyXJatyYrf5dzNPQ1S3HAPVmmIP2twYbVgGJ7NGMOPEsjXEyT/yDCwtOCpor+lNaEabBVP4ES5ZLHB5DyONcZf+3FnUsOgk1TZ9EqwDH29A908rsSFWHaJj3oa4nYX1Fc8UZUyEF75BhulblbBPZHa152xRQF8tFKpc2heUMJr1diLxRXCiQKqaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqlDYVNhPMXS8SeX2G+POdNfXYLYSzFvhf2eClJoX9U=;
 b=B78baXF0mqKhZSzLt+ncT24kl3tEjGtGnwVAjCn567lnZ2DdAFChkcYQEc1USSoCDS1sb8I3yNstw68O8uP8k/yW5t15bDw/bZ1B0Hd1bT+aTvElW82slJVOFXKCiV+iVGeLKKEc5ZIooqd2YMpuN5SG2NrMZ2VJ+ZfVBiaArWX5uLnIHMeOybxXWrloYuKvgttBDLnB17Oqi/hgxh0YjP8EXfxeuhdj0mDtqYZ2kB31RycwgOrSV4Er9rlZSAz/o8kCw/6Mztnm0cWv7P3xPI+iJjSACvVi/XSLl0FmfMpV99llzB4NJShzbZ9DWFE8Uc1m1D4njiV81HQpD7zUcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Thread-Topic: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC] virtio-net:
 support access and control the member devices
Thread-Index:
 AQHZxeT2Q5D2+syVdECqHrje6hzlHq/YUmCAgAAS74CAAAGPkIAAAc8AgAACoHCAAAFdAIAAAN7QgAACXwCAAAH+cIAAASWAgAAY2vCAAR9QAIAAAoAAgAAHcYCAAAfd0A==
Date: Fri, 4 Aug 2023 07:26:01 +0000
Message-ID:
 <PH0PR12MB5481BE16AC810CD3A6D64832DC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <20230803054333-mutt-send-email-mst@kernel.org>
 <1691059929.235804-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481B5B3C5366CCACB221083DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691060652.3764465-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548191AE225B08BACFC0C350DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691061508.9066079-5-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481CB7BE555F4672394A6ECDC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062204.2378864-7-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481E104793F9E68E1DC95CADC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062877.0013635-8-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481C3CE21016385BF7D6FF0DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691129914.3255427-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481F521F146049E5E483B7DDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691132049.7182267-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1691132049.7182267-2-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA3PR12MB7806:EE_
x-ms-office365-filtering-correlation-id: 6ee4416a-99ca-4a5f-ed13-08db94bc0e27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mMxYVuEPbN02wr/pZontDB3KuZMYwBGzKGMc7C0rYcl11UIqk1CMGFckScvoV7zVFXYzzEF5XJfW2gDA4unpTDjkICUdkXb462GBjljvpws7Ke3LWMnfG/SJVdu0oi+qBfLJvO8Ep/09RUzCem0NYjSseG+3oObbbDC5YJHBKc2T+8vCDOMN9fvsBZeIlnEZ4Eb94JiObeubCVBFX/tcHNhdjDKFzyihKKAyC4H+/YRfcHULpzmiqpdYYenVDsm07r/mUBZXQCshqqaf+ALnElAHUwQ1JMuN7vy1VNdAt+L77TP/UtAaRv/TeCq1Cpfy9/htYxRMXPsKpIM6Hdl38Q4m/bwJBMJWACCUQ2WGOf7RoRtK8BYmiBGoCKx7xQVZ/Rp/kQf0vlIeqlaNpmGl2FQTiBvZ5cSbsCV+/N0BLK99zePBGzEIuVg0nh3n4m0gIqIqTLvJ9VHSkJEMqPmJzFLUNIUpfQqm5KQCfUkCjVPt6rXdBl2eNEviULoPRYyGGy6zCDFJAzIUIAF4groAUFpInQ/LQLznxBF3/W0M8xx68mnA92Y3TS9I8cfSMpHV6Pu0c+bMIX1kJwy+8KKsL6t6AA+MUf6a1lv0sqdq69NY0NX3rbC7hbtRRUtlcF8J
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(1800799003)(451199021)(186006)(8676002)(26005)(6506007)(66476007)(2906002)(316002)(76116006)(4326008)(4744005)(66946007)(5660300002)(6916009)(66446008)(64756008)(66556008)(8936002)(41300700001)(7696005)(71200400001)(52536014)(9686003)(478600001)(54906003)(55016003)(38100700002)(122000001)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hkw+Rfe6K1cj5G5/1m5e3cUDk9UM90y2qZicoB8uMvWLHQswKB2h5TcnCpsg?=
 =?us-ascii?Q?cVuqkf6PLSLFEjb/R2IklyTG5YezcNHlePVKIoHQv1FFFRkIPMG8mHhWhnoq?=
 =?us-ascii?Q?3jkQ8IBc6EC3DzpXDWi0/EN7DXwc+jly8siT3VkQVtypqpPDOz2vthgnfpM5?=
 =?us-ascii?Q?Px7ogm1tMCCJncvdGTlJqTQADBXTAB9fo5XYTyfLdeG5V9nz8Xc9wLqC2a4f?=
 =?us-ascii?Q?9soTWWiP2QXM2thvqpBVq2jSxZTsFBbc3XaBra2wyoKyskb7wR46jY56sFrk?=
 =?us-ascii?Q?DIwxXJrwZxOLbgC32zQD9e1HURR1BgM2TB5L2Osgm0QTY+1MdBMNgzmH4U3M?=
 =?us-ascii?Q?3kjF5if3uW3ka+SwHFsKiL3ulPczPwtu6/4KdfV9NNsm+tifNPkM9/Q2shRo?=
 =?us-ascii?Q?AKAUDQ5woc02/7E5q6a1LBtceHklr1kfjhCx2DEKuSd59eQgqXvgWWTUNLM3?=
 =?us-ascii?Q?R8gT6XX9VIsYN41tUXmTWrVikQOEhQpFz82U0OHAbahYDDcXEW2iDrwJjS7m?=
 =?us-ascii?Q?aGKOkk2kIr4xQ/CygBwqc9B1Nh/Qj1w7UdYiUUvZofKqpVOQJ/tPHmAbmQNP?=
 =?us-ascii?Q?9pyGOypIew9AZV4moYTj5+lzWkGA+AwT61FIbFF0AREV0OmHsN5eefcHR8lC?=
 =?us-ascii?Q?0/Y3GrdXpimuq4EQPmWmaI0nXnqqu8kb0WHlf/tecumBkEgp7YPAHyN6XPvG?=
 =?us-ascii?Q?cmlKHmO6wL7hmBlAtbaTwXhmYBDK01e9GwHxJl/rKFoGOXJvyG0gUmIXlnZL?=
 =?us-ascii?Q?N+tFhEEhjE6B1YZ6EwDMrvBUUr2Akx8GnJ956kd6uZo2hHh4IfMVge7W4zFn?=
 =?us-ascii?Q?+pGQ38GEhlGnzG1q+bykr2OVOcDR6WmKtja2VrX/22wXaAb462KQ4CkooamK?=
 =?us-ascii?Q?WBwLA0c4aJU3lfIPVrSqopFoWD7UJKkYXcQsfJdkvUmAelyp+9bMpUbowvoH?=
 =?us-ascii?Q?2fddrFDH2cE7488rErvB88Ox46GohYp8KavotEUXlz9yxgyfU6HRf9fvyAjY?=
 =?us-ascii?Q?YdgwSC0FAgbgE3b87IL6nQBLm9FJEm1cjSpFFTQyNxb/z+iNGAg0mY8Drsam?=
 =?us-ascii?Q?cBgyvDP/lx9EXv93YpINT7OeGm43UganT89sMcef4LzmcQKMfWjd6T+r8KMI?=
 =?us-ascii?Q?SVoO7VjyGX8lO5rbXd33MiBQNj43mHfLx2ewTVSI5kISdrmeaoWEeCmvkkHD?=
 =?us-ascii?Q?WFomRqmaZJyL0Sx4phAW1mTF+JbDxNjRX/P0I/sgozNhX3kKjVXpF/HxgLB4?=
 =?us-ascii?Q?qTxkc6liEa+zYc5X94LNQXa9BAK6Tt0IMf9BqJNa66Lg1k2oBI/DLuDanKHT?=
 =?us-ascii?Q?4t+OWTaQCGXAHqbcSYTkxk7VT/4GyRaJg8McW5Cd2ipBIXhmgkoOa7pDqH6P?=
 =?us-ascii?Q?7V4gZ4IqANCuzQUsidQapaPq2GEDmdMI5NaSNb2CBH+8ipm0a5Q63H6DlhzO?=
 =?us-ascii?Q?VzUbqvL3biTbK0QJAJ1xmkd5gdsHetweH1SuGMiX3DT8MNvBfYSGL8Mvdqij?=
 =?us-ascii?Q?Jp65lxBKg3emB78S19oJtNWIYX4rSEEic+5pSzV8YRWbxlzZ5MsrRqYzhgAO?=
 =?us-ascii?Q?PRqcD7RUS+plJCH0HGY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee4416a-99ca-4a5f-ed13-08db94bc0e27
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 07:26:01.4821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 04JFKgrUYW/affA+Pa0Wx55D9F2YHYUL5ICUpYxX+235E5zGWD5C/jL/eR75C5Yn4pOyWW8c5iLvjpRdt9U91w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7806
Subject: [virtio-dev] RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC] virtio-net:
 support access and control the member devices



> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Friday, August 4, 2023 12:24 PM

> I know the gap. For us, the switch is under all devices(including the own=
er
> device).
> So we need to control the switch separately.
>
Right. Same for other devices too, including ours.
Hence, it is also located outside of the owner device (on a different syste=
m).

If the switch is not a virtio device, does it really need to be exposed as =
virtio object?

> In your structure, the owner device works as the switch. It has port to c=
onnect
> to the vf devices.
>=20
Right. I just put owner device as switch for simplicity of the discussion.

At this point to have port for owner device requires creating a dedicated s=
witching object, to be located sometimes side by side inside the owner, som=
etimes outside.
All of these cases to be crafted, please rethink if this is _really_ needed=
 as virtio object or not.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

