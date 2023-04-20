Return-Path: <virtio-dev-return-12335-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1B2C77B73
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 20:52:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0057C3E309
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 20:52:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EBACF986667
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 20:52:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E1B6A986637; Thu, 20 Apr 2023 20:52:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CDBEC986635;
	Thu, 20 Apr 2023 20:51:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaUYkq+v2u8Jq7t2wbobUMVQRG5SSov+imHXLtLe6pnvU5O/byRe9NQnTMI1tq5GsimcOxF09wChHCRhoFehgcu0tBRnEBtombWdWlAgM9JzX8ALR+u2Eb4gIOPFyXXz4rUmpL7sLTIujFZOIAX134JemqQGDKIpZD+rusv4tRalwMzsB5gxYz9Ef24Bq+pgmo2WE5HHz+ojYJ4Die1mE9xig+EpBiXEqqlIlugbeoeC1N4e+BLqIL0hufO9I4qRKgj2eonz8RwdTmujZtz9LPWJAepR1jKnUzpWdmuXwUOQSEfST+yGCpW3alhpwamSwc1zapBZmWHZ5qTQwTDl9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCWcjP8VDXj8LlTa8QpylXL21Dp9ylrue1qU/hQJrVY=;
 b=Q2Gqs2fF8eNlovxEbOB8sWxOdLlCrqVUj00UuHAnAYfjQgcRemx8BCJEjx0PvB3gCoq0TMUcgAEyv+MZm2Bwp6qiGT+EMzqdbjuPkOJrmV1FqXoKtf0LqVMjsE9HrkxblUeODhNS7Frs8JRuo3qbftlbCjBUQzZR+4Jx4U8Xz1XKbSGwBgTRjRyrfoHN5gbzorI2ejH53TG0XBBze7N/ZfWUsL1DjxRlQDUg/uOqD2yhOez8fZeGO3RpMTWdhy72fO8gHh2FyM3Y8Xx/t09QBTBrWJGLTNqjmjslMH4drq9eOZJzEInh3Ex1hq1lIS5RtAS5yhjAeR27ZUxilGmxEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [virtio-comment] [PATCH 1/2] transport-pci: Improve config msix
 vector description
Thread-Index: AQHZc8GeBKvG9y7ZQ0Gd2kv7EwbNY680qlUAgAABTFA=
Date: Thu, 20 Apr 2023 20:51:57 +0000
Message-ID:
 <PH0PR12MB548172381252BEB73CAE6D44DC639@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230420195158.69737-1-parav@nvidia.com>
 <20230420195158.69737-2-parav@nvidia.com>
 <20230420163800-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230420163800-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB5437:EE_
x-ms-office365-filtering-correlation-id: df1c12c1-bf3f-4463-ad54-08db41e114c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1VdggGBzEzcWhpMFlQLhlgzc7bWhUYuNje4O6lZ7msYZDJTWkdGQqpVSgnnSghnpGwuasUDtPw4iTfz4AI7+lI7OjRlRhSpNdUhYyo2UP1V01c13HEq8ZPca8CVFE5Id7LRFJ49zxAy1yTLlcEbOpo4lmOGjNjgA0QqXGLnzflh0LJouXwGHdyRKlBvZA0CAuTILZh/ljkRXWAvhqmoKZ9N208U2cqXJwRY8gsbK8D7hH3nkZl75nWV7SWG20SN5D0o9Izd38PTa14DyK0POUWpHal8JfrIMyutPPJkOZCNPdyuDfnP1AhyzxFxCZcAr9pzyf5CQ0wP9sFMIbj/A1VsbAnk32zra8fRNIglCxdNSFQD62UO89mWfPAnulY2JIrtfcVXiurZZY9bfgBOuv0qzXPoNd6Lv12sh9OfX8G35B6vordL4gclvsrLteYrqIkKRTxwpVQNjVFB1Lr14hC6Fkpg91TurSRkdkezggtKyctk4/yJPS0MWFJt52Sqbv2oNgUphyNMe8nhsg7OW6Y49P1+bbefFe4UE3YHE3MCaYJO684UmgMo16Jk9IhHagfL9ttrLc6jUrU0abBgKAzm54PqFyWhjiiPa4w6a8iMATO6DIiXa36OLQDa+nYdd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199021)(38100700002)(8936002)(8676002)(54906003)(122000001)(41300700001)(5660300002)(52536014)(4326008)(6916009)(316002)(66476007)(66556008)(66446008)(64756008)(76116006)(83380400001)(66946007)(4744005)(2906002)(38070700005)(186003)(7696005)(107886003)(55016003)(478600001)(71200400001)(33656002)(86362001)(6506007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?v2JjpA1XXESoBVCw05pcxIojtNWT+oQWGQTzibfsGO7KYNKMfkt0yTm8GxIq?=
 =?us-ascii?Q?z7lFAJdT7wz+CWMfRXWKCE+uCTon3UpHfejXj+5kpdtlM77IOuAM7ffYXBRv?=
 =?us-ascii?Q?qAZ0P3Iii3B3/LgDcErl830AUGh0YBgNGtmDeg6RxaE/pNRhWapGUXLqXc6Q?=
 =?us-ascii?Q?ABqtmo4J8qqvR5AkAF35zAiFnm3CFT99rlblGj4mfNm3fQx8/EObgYoaKes2?=
 =?us-ascii?Q?dC1cqY8qNZMNpmK46bFLzWR6bPBEZGkJoLVPq7bM0r5GvXZCIVhyaTB3ZJxU?=
 =?us-ascii?Q?BevdQhya6xo7WekzoHqzj3ukQefEhTNz+A1bFnPPz4frqkXZOmt0TlGh2Qbo?=
 =?us-ascii?Q?uEyDPs6STj1OybDYlXyONxVPzik+dVnoY/3dZt8QTeMZo1Sa0kfh6A3rHlXe?=
 =?us-ascii?Q?vPeKYvm5iGPWxCO5VBDzJwRF/nf4QZpJk3QEE0bJdYvESjWrQm69xwprBG6i?=
 =?us-ascii?Q?+DPAul3/aFqMPOYIQItUVKq7zikLOTmzIPMUjwGVGUSdRVyLKM+oPSN8oDue?=
 =?us-ascii?Q?gH+YCX4Jdby+zIkX89TyNqz+bz+8nYz1gkv+UxZ3BnwORMq1arvUp22wxdTq?=
 =?us-ascii?Q?UoAnX307WQsNa9IKiPKuj+SbwGXQgFSID9dYmdFfcP6ihBk/HeyaGNONagEo?=
 =?us-ascii?Q?SLoaMi1/qEi/JAXXqWyJwB3Ribgc4rrzIRmBpSAjUX5pRoPnihdxOfMA/nQs?=
 =?us-ascii?Q?56y9t+gK7zmk7ocIC9S7+5xpzqdAC1XG3OfFP81h5zUbbYNZ+/46/DpYToWj?=
 =?us-ascii?Q?N7L22ogZrigj6Z+X/K2AGc9D0apojr77+OBeFpQcQWvFTe+jHxWWmVQExvuE?=
 =?us-ascii?Q?yJhswADGCSk/fr5LeOVye85mAYGw2jRO3YT+bG0+g2nUysYOUByQcx18x0nF?=
 =?us-ascii?Q?2wnE6TIc6yATNb4KICO144LQiAKmG32IaKJe5Eids7ICCdMy4POcWXxMd+ar?=
 =?us-ascii?Q?L0aNiXAM4VDgU2PKNsCJ37NwM0zQu2AXjTALCf/SNUcRtEstul7HbYWNIJuG?=
 =?us-ascii?Q?BGCqdCyRu6v3X6CucBQSoqLrVa7JK6MD+ELir/1JVcVU4O6I/S1F07MTMmg9?=
 =?us-ascii?Q?JHzZD3yV4rCrLiTSZmvmm+Sq2JxIqH1Gojiz7DpR9KACj2InXd+6kGzZXcaq?=
 =?us-ascii?Q?hdcCWfr+KVPOTagjY1boF9LskHwMSOlIr1Rf2VFxZSW3VEqOLwwTDysBI6E/?=
 =?us-ascii?Q?YiEwXwL+600F5dxz/ueHk+1Rnt2P3+HFG6VRrHjPWhQ6J67vP/O4AXHXptWB?=
 =?us-ascii?Q?ZMVnqzUflswRCHKuUBTynhjtBzB35J0OXq2uTCj4qAi1VGifABgsZZT3Mtym?=
 =?us-ascii?Q?4kWcLl8eBFoq6b9mzgKLDFXZgvLDR72tB/UlzdVEX/eSWrjJ0qiv/LGmKFep?=
 =?us-ascii?Q?Kq4Fdo0ViQgyTjH87j7g61BD1P4FL8FpBijT0X4mRZPgXjJ02YRKyxdkjMLE?=
 =?us-ascii?Q?q+NkcbQvsoAi6SaOi4VJkSpS3UjA3b5CaLH8OX08n1ZhOL+uPFEVIc5DGK0x?=
 =?us-ascii?Q?HSgYSttQPaZQPkb96vKg0gN2JO2+TiDEiqFeMYN2XeZp7HKRtTIjz+RBxZtm?=
 =?us-ascii?Q?ulj8gaowJbJi4eVWWZe3xxnHWiq2RIWcbEgSyKr6r1Z+j9H5q0aQs62Xzcmu?=
 =?us-ascii?Q?nW9M57LHLt5OxuIJenaAFy4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df1c12c1-bf3f-4463-ad54-08db41e114c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 20:51:57.4217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qMh2ws+G2Cdwoi+IZApolLMopUfMKydZQo9Sccs6kA0Ib/8tcDcWEX0JLVLTxEpXZDDhwbJ2krS1GZ6MThNM7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5437
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 1/2] transport-pci: Improve config msix
 vector description



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, April 20, 2023 4:45 PM
> >  \item[\field{config_msix_vector}]
> > -        The driver sets the Configuration Vector for MSI-X.
> > +        The driver writes the MSI-X table entry index in this field fo=
r
> > +        Configuration change notification interrupts.
>=20
>=20
> Urm not exactly. there is also a special value of 0xffff.
> I feel this here is just a high level description.
It is high-level description. 0xffff is already covered elsewhere in the do=
c.

> how about
> 	Used by the driver to set the MSI-X vector for Configuration change
> notification interrupts.
>=20
> pci spec also calls the entry "the vector" so I feel it's ok.
>=20

To keep the text consistent with rest of the fields, how about

The driver writes the MSI-X table vector in this field for Configuration ch=
ange notification interrupts.
It uses a single verb instead two =3D "used" and "set".

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

