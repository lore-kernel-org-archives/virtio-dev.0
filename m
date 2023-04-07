Return-Path: <virtio-dev-return-12065-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77B7C6FD1D
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 15:35:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 90566339BD
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 15:35:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0F47F986738
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 15:35:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8850C9865DA; Fri,  7 Apr 2023 15:35:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 64F309865DB;
	Fri,  7 Apr 2023 15:34:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0Mo+gqjiyqVWNBU3ernNGS64y0d8mWmsIL/ztRMkEe3tym4gUUUd0MrJeDpULntcnXKQ36jg3KIvgT4jKS+SXX/yGnMJS2FbqGdoCuNRpex567LDMN0lTXHu7yK/j17+/oJ5/I+DHWoYnra2Y3gQVCh7agKu6dfiIuDq57DGSoges8yFis0oIAJIbCGU7gVkyogdwI9zWtP7S1bykQHuG4Q4rC6Zp8vayNOkYEZGhSJ9iRMats6OLk9XpJvREUrIPEo0uaEHZF/+xAzFfAS9ZrN8HA6fxWjhaGRY933xUc/UUiePKzC3KdC3+aQctPYGAD+V+JrLXcLwz5dsziWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vrYsi/cvWibxdzZWcEy2NmKJbtVLeEAGgcMJAiAiRY=;
 b=kZLfEElZR7rSc6p8z75Vl1A1ADZbs4OJykPjuAgprmoxkhXLZxh1qrxNOx0F8vlHQwFeMMTaLC68zD3hGT73KjjNexAoQv13XlLaAZq/A+gIMWEKeVAHtapIV0rFVI5rl1Lp6s8tS7/e/qIB0XdyCaSQeFqPcIimjzjF3DzjvYo1m4MPSQFlxKCoUsq1c9duJH8qtUOoaopnru3AxGYTI7t78TJBuyzO/Gu/0yVlxeLWrPuEccH4aY4iVvA2caflc8B3okouVSwqIw4r86cqeNx5ZwVFG85NVbuHs0yfXJ7lWf2CKfxghmlWQfZLvdkr31TAkxLRZLANl5AesLe/Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com"
	<sgarzare@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-dev] RE: [PATCH v12 01/10] content: Add vq index text
Thread-Index: AQHZZ1r76yVHvMh3sUulmC5quinH068ccIWAgAA+kdCAAwrUgIAAQ6Ag
Date: Fri, 7 Apr 2023 15:34:19 +0000
Message-ID:
 <PH0PR12MB54815B064A1622B963EEB69FDC969@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230405010657.612529-1-parav@nvidia.com>
 <20230405010657.612529-2-parav@nvidia.com>
 <20230405051801-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810141129464569ECCC825DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230407072815-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230407072815-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB6018:EE_
x-ms-office365-filtering-correlation-id: 0e08a55a-ad83-49d1-15b2-08db377d8e2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yTYxht5h4whfncYDL+anIX/hAdMvelx6RAg70AIDA9zKP7sBkFtnUXT8ILDCY+b41EsTfBA40u0Ko1uAYApbAySnbPp+Y3V9/OwIP2+5pT+fh6U9MKw37jJkriV8CgCjKgAFNLZJe2b8a4/g2GuVN3j1B5iQblksGAPk1rYqO/bVIZGNvlu8zeOAO/lFjoQbgdzKQOY70Q09lhZavVjbt7g4KRaoTNFUpP1H0QUrkhredI9kpXO2Kkzolf+IOTDtt+9Uwfwr4fNjknRQ4vwICXR5BmMd24NibLqxkP0QsblzWoE/UTJK2GAttQ7XXdHTulRq6JxyjWEr4+YeW/I5nc5cJBEjblMbX48NnGsxjQ7KjWqN5BQOk2m7XuSybZTFMlVnKgT9meOgnfDH7r9XytC6C+owSDQZDFGrc+OdnIqVvbf6Fwkbrue3ULvs4Cd7tLD01WA2MPJ89rMFXF7AqC8IK/R0Nzdrcv2Clkz8Cax6pHQjQGUmXYb6Fz38D4E+xz2hw8nhOpuCJgtjHp9YeewyQ5c8SbZUxcSzp9CtiW1YuwRwnZfwvwJFeP9ApfavI0uFMzdFsTprqvjybTq9q5B4LAiCTazy4yjaCLLJOTTC8Duo+2wtgMpo9I2ntgc2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199021)(122000001)(38100700002)(86362001)(33656002)(38070700005)(7696005)(52536014)(107886003)(8936002)(4744005)(478600001)(316002)(5660300002)(6506007)(55016003)(9686003)(26005)(186003)(2906002)(71200400001)(66476007)(64756008)(76116006)(6916009)(66946007)(8676002)(66556008)(54906003)(66446008)(41300700001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sQTXxsWQ7EnY7QjLDCuuHldmnO5PtvVH5n1ZJlP3jEV2oRKDswR4Xdwx3V/9?=
 =?us-ascii?Q?jDNEKHo9c27D3vFRW87Fkr36vn0ox6lkVVviOliKKzw5Cd/vnz+Zm8gqahTh?=
 =?us-ascii?Q?MGDAnCqe1FGxqrkRPOduaaS9+s2LKbUk7gKy65cq/WEVFH/Vv08ztFLBYE7l?=
 =?us-ascii?Q?bGy6oG5Qrxv3yMw41iGg36Jp5bY/2ZoELpZnhbgNXe9/xGAKdokwmC9ixIAt?=
 =?us-ascii?Q?jGgDLT9CPOPlMy6R4qZ80XgWDkZb7glcyCGRrd5RUHiC22HdqqFVPxUSQ6/E?=
 =?us-ascii?Q?P5+n0o7Vgcgx3gm91MFUvO6LATdjYEKp5+uXClRw2Tc6eZi+wWlcaIa68WVS?=
 =?us-ascii?Q?eBnQb/wJOncXqQd7X1ZdPZjlfakQemvU2APFT8H5UJCeaa0g6tDL2RYqBl4R?=
 =?us-ascii?Q?tm07Oid4af4n1p+runXlet9iL8hfSNDwbW+oFEHf0hE42dyuJfJuheNnDfc0?=
 =?us-ascii?Q?xgGdmVAjFe7wXyJklBwxtVeZenINLVRUZOdMcs7kJbiuBKEiwPrmakWcd1Z/?=
 =?us-ascii?Q?OhwaHfk6wNEdkyX49u8XB617uuntdL9KZu0DaGL05g7LVrldTZUWhZ9GN83C?=
 =?us-ascii?Q?m9DyDkjzZQxtKTLsIqzaEFUZOQBSzIca+QL+C898u36ds1rE/P8dKNlnYZrQ?=
 =?us-ascii?Q?vHCtwHRdMsdu5hdVQldWdmTSvdTkdqvOoLVYTXMAcR2BNHLaQvSuIdAK5C8M?=
 =?us-ascii?Q?vMRpkrpvZHNbIBr1QDgJfyZKlkUyNX0PUnq3TnET+Ofm8W1h/dSDakmr23mR?=
 =?us-ascii?Q?zYCTPUhP2AEYps14hCmH4/mv58JomYk3FOJR1aD41TgbULToV5XROg4z9CNh?=
 =?us-ascii?Q?a6ktVRE7vL1JSM7m1eMxcVo+IRKTeiTfXeKYPNLAsx2vSk8vCdpqwbETLgPD?=
 =?us-ascii?Q?bQrhJN3vvooXMpDsvgCRTyygCVcVJU9ZG1wbTwIupnPKqS0U0m/OSKCOYhso?=
 =?us-ascii?Q?PGmqs2WODyOeZrLJvJgQyeq/BhTUcA3OSUZB3XJ4+6Pq2yfFHj7w46AdbXOu?=
 =?us-ascii?Q?J6uBVQAGzWvRdyELiOo7jCUYuapzqrhN4ISa42WcTfPB60kT1BckRj6ZnC5h?=
 =?us-ascii?Q?u41sCeP1fm0Zxkq+oaCiu/KwrfLdO/c6gEwWRn3DyzBPkRclT3BiZVCr/H7N?=
 =?us-ascii?Q?5dEJfvr25/wGZrpmtGemY7wiAhuR8j5BkCHFJtNq54rS3O+KgaP2IZDLM1K9?=
 =?us-ascii?Q?C3aEFARY/JHzUqytAWY4tAgWAQn+quonluvYdoYZYiHRQOxZnLaW6r23AgYF?=
 =?us-ascii?Q?t9yh9EMlkvsIG9S8bHuu05RXY5vEMtPV9CCFG/MY9Jz5/F8VLOJOAz7UMFNB?=
 =?us-ascii?Q?H+oBsxuDDYpiDcU0uwJZ4LGvuof3T5afIWTL1WiK/tN5ljnWh9YJBHMRQEGz?=
 =?us-ascii?Q?7Jh/Ptw+QlBU/yOUwE32kfCJe4LclwElJPgfevF7gSwTYa+y4iFRe8GRC5Jv?=
 =?us-ascii?Q?S5oYYhfIAv+FCB8sqbyhSR8p+4Razqy+jEQMtOBwZgl6D2EZ8bAO5v3AQLJm?=
 =?us-ascii?Q?ao+QgaxK/meDaR8b24Mcod242opkqTpCPjRXGceSjROMPiw+mNwQkMGnwsTw?=
 =?us-ascii?Q?rZMUbtm44DJHZP4LyMw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e08a55a-ad83-49d1-15b2-08db377d8e2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 15:34:19.8374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wiv5ajzCOvt2HM40RYNiQHt2rffeBs8Qd1g6KbXwNHh/7Pbbf7nzel2SSM1D3RHVkf9k0z/q4KVq6s1VFHWBuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
Subject: RE: [virtio-dev] RE: [PATCH v12 01/10] content: Add vq index text



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, April 7, 2023 7:30 AM
> On Wed, Apr 05, 2023 at 01:03:29PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, April 5, 2023 5:19 AM
> > >
> > > In fact can we just say "virtqueue index" everywhere? The less slang
> > > reader has to learn, the better.
> >
> > Wow, didn't know that "vq" is a slang. :)
>=20
> And so is "virtqueue".  It is certainly not in my dictionary of standard =
english.
> One term to learn is enough I think.

Sound good to me.
With above reasoning please replace all "vq" with "virtqueue" in the commit=
 log and the spec area in aq series v12.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

