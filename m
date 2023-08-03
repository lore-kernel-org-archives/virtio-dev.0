Return-Path: <virtio-dev-return-13447-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8502C00528
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:25:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1C7682B013
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:25:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0B5DD9866DD
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:25:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EF9349866AE; Thu,  3 Aug 2023 11:25:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DB8A29866B1;
	Thu,  3 Aug 2023 11:25:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5EYxdgvUsrWcbuxm/w29k2LCtnzneWnI8OY0QvjhF90ypTOpCnNmC6wM6nkwsP1gYiuFHE8QOyj4dBCG+q3kzBNh5xTfDQdWe0PlWiUbms1NElzjBqq+ycFRLxRF88k7aXg+820lXWZ6OSNbBDb9iiaXvMtiFXvhzGf53Vp/cIPNK7wVoAoQ3gM8L5fDcP9Ea214nHTpQTgLul53/n2TAKyeWpePZHV6z6D0L2erjgWUFoJQ3e3sg55EDn+aVR47c8diGYywqcpv9hTGMQXErlZ/lFnAS7raCHQX6bPS/lVlGgrhKTNWGQ8ZA+BNURzHRbKBGCJlb4yA7HqowwW4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Oe8Io7bNRv3UcJ8yI18p68LC4p7LK40TNdV/ZiS7rQ=;
 b=Tc2VbfajxlAiKV+pc3RqdUu824vPjYmMEOigQPIwMBlaXMHlyHZkb1g2F79/tf0Mgn9q0Z1tJ4JHdSEDZMhh8akTNzlBx49TBV41u7eHnnkW+62wj/qKcaMR46D0gtSU/L0ac2tUhMxot9fyt3gc6aFvjSNkcZKcNL8Ak69GztQ6+SNiQZhWjpojhYbfsIimyPS08h01PkePvBzZdHBnhqKcCgZyApGPfzIFs4v0wKn6HaDPXbr0Immyx7Qc5Nsb2YroavPsv6ORSXzUfpZM764tvhGXmDAoG1KiXapuV1r8lOZlGvVuRD7q4hH+8o37oVYLh8otsJPL1s+0aitOSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Thread-Topic: RE: RE: [RFC] virtio-net: support access and control the member
 devices
Thread-Index:
 AQHZxeT2Q5D2+syVdECqHrje6hzlHq/YUmCAgAAS74CAAAGPkIAAAc8AgAACoHCAAAFdAIAAAN7Q
Date: Thu, 3 Aug 2023 11:25:31 +0000
Message-ID:
 <PH0PR12MB5481CB7BE555F4672394A6ECDC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <20230803054333-mutt-send-email-mst@kernel.org>
 <1691059929.235804-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481B5B3C5366CCACB221083DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691060652.3764465-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548191AE225B08BACFC0C350DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691061508.9066079-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1691061508.9066079-5-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB5856:EE_
x-ms-office365-filtering-correlation-id: afec7487-0bbd-4044-7fab-08db941458d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 amctDiP0wPjzKJef9Ac/Mm/RiXhaDLaWOTJKsCyfqxn/u3+/oc68zQIBo3HUuKRh/zgQiewAbMyL90UBHYYU8OvE3/wUgu1hk22lkV5/JZx/wR5fHcVWBUNLK3OvtQX2xqnlffeMek2RNeM6+kRI68HM7qnWXhVdLoesmTrUaUw6STIlnUs716h1QLOlNUiUJOv/n8vsKA0yyjIy6vLaJq5ON4QTaT0PKWqIlgJg1ZRZnE56LxZMQDKwpvkyA/5Sjl0tjogfe1wbEk4OCBbXVbESYI2zCcepU426ZYFHR5JEnLT07NAf5CN5HllyyxeuYpKmCRd1ifFNLfiWY3zgbAAbxRhtMdlUo4zxFHOMKS3rxlf8UlOYmnKRubb6lsA+P77p95VbjuKvUXMMKwXuIrnFUa7olvWRydf2C+u6JQmSNzdtvxUZqdBjgEcmOFZNZ/hbVQAMKvg9aysRoZIUSlex9n4NGmvP3eXkL9Ce1sdATlUOhHDUUInNuwrHWhPXAWl25RHp4lZbmOFky3Itr7LI9oeOAerDtaGJXdKTT1TzXPh6aZfpGQo1lOqQAE/BzTfMRC9iSi/yXoBZKXiUJt2OKPY8pFg76ybF+IrPL4RIiiapOTm1p6xLrALHujan
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(83380400001)(6506007)(26005)(186003)(41300700001)(4744005)(52536014)(2906002)(66946007)(76116006)(4326008)(64756008)(66446008)(66476007)(66556008)(5660300002)(6916009)(316002)(8676002)(8936002)(7696005)(71200400001)(9686003)(478600001)(54906003)(55016003)(38100700002)(122000001)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PK4+LB/aY8YI0NqpOFMk/KBMx7U10jXsZNwa1KvcBLlUF+S/xDaY42GSJ6ZE?=
 =?us-ascii?Q?l6tc4k9rMUp90rwCkvLIpTCVDKSCGtW8GCQ7oMAPl82TeOGJuYNVhbC0agU9?=
 =?us-ascii?Q?QVhW5SgWiebT95orKVzE1jGGevvS4YaA2AAfU9oi1udLGmWml2xD+ySBaYaA?=
 =?us-ascii?Q?0I07NqmO4XdmoGHX7oS7kVNtuiCa/n6xIF5EGFOxZkFezcIJ41hvreRwqsQi?=
 =?us-ascii?Q?mdmtR1f0D5ZFvPld21aMAS6aJ5M9aSD+iXtCQfY8pi0cBQ7g7kc0sB98h4Ud?=
 =?us-ascii?Q?J1RfX2fdCptBA/jENKqLUGSmxBK3xPegqVUAHQuqg1eADWZhLPPpNohLqJKX?=
 =?us-ascii?Q?SbnngCs4MKBWq5DJrLRoz+8NiDksvBoK/0WdCosyLVgg/VpJgAgUUc5R6QUD?=
 =?us-ascii?Q?/wJTafs46sJnteYrZv31mBAxGYmVUc6Voj5YJOFvv5PkPBtqpcrZF0eDRJg7?=
 =?us-ascii?Q?LpA3BQMjFoOyDpl7inli7JicLfGawU0lS108bRh54Gna97oW5XmCU9//B8EM?=
 =?us-ascii?Q?c5jLkQQzs+20k/uqY7HO83jBGusEsM/aewP35jaXIXTCJHZuuWDyz0qsppgi?=
 =?us-ascii?Q?0XCgC8Kj2e6oFNvhrIu0Za759BZBjBhbBjDUBkBvcXvbNaqHhbDGNf80yOJZ?=
 =?us-ascii?Q?h6AUku9r+yMgy0tZ7g74ms0OU9aZWTimDJLkZBlCbZ2BxnYSiFwm69L2crky?=
 =?us-ascii?Q?3RNX0huypUbOfAfJIrZ6K/QBbYCLXFdcCiH62fVE5fD1qKh4okH4M86hyaDq?=
 =?us-ascii?Q?0x6KAbzdLmU4BlJUkocLZjp09mWk2C8o0mLL3i+YqgVA5LXAza/5mpQYtl/N?=
 =?us-ascii?Q?mLw+KtytLhsKBL1TQ8MyOVKqpFLitQkTYn8NhNTqvfYvjSYlvYRI031H/dAu?=
 =?us-ascii?Q?IUZEzYT9wspJuVtKl2ttkmWU9HGv5kiUfzjWlnGfdK15ZDG5tvJI9CU8XmFu?=
 =?us-ascii?Q?WzFmD5UjCT8b07MiuNlJIlNJt78m5wD6YG5ms/+IXCLjR4oFj3Bmnd6Hi01+?=
 =?us-ascii?Q?1zoCGToLRP/8hbibZ3H3rWC5uYY1WFh/YS5nqdy4fEFjdY2v0X4Fk7/hVib6?=
 =?us-ascii?Q?CR87DmM83qPdlqB8MtqkTntBRDa5rZbq8CykLUAetWAAPy/peH9Lcw0pkIuu?=
 =?us-ascii?Q?wjqkEsE1n1HigXvUbKSVniUiDTMRNPRhSvkEsEZuq5iUuD+dw9cjDJIi2q5Y?=
 =?us-ascii?Q?P/7gXSnw/f9rYlO5zqK/FkZNAPQqVFzGn3b+nxNl9H8rO57OMYQfh8gKDzpx?=
 =?us-ascii?Q?cn+ODN1zpLt6gqzEUunPYLqtRByvaEM1D+wAQv2HaaUqYqkqSm5olD17yft9?=
 =?us-ascii?Q?3Yxbv1VRd9pWPK5o0jjyC0enm6FDzTqOxggb+7P/zSyPIX3QiHKHcPtW/nSk?=
 =?us-ascii?Q?P4B6ZB63U+GgZlUcTNNvDxAK2Nanx17YPpmTbn9aUe+sqoO0bho+BxvroSZj?=
 =?us-ascii?Q?Va2VxiWsNj+JwzzbSeZ3vPIhKUPlx5pbDkUt7JG74cjDbbVgSrITXOiDqHjT?=
 =?us-ascii?Q?My9zjGoofohIHXDoKKF5UK7kQpNv0wIXKQvmbyRQxgNT6c8UPtQA33lRVRIo?=
 =?us-ascii?Q?4AQwxYnBPiFVgZMXLso=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afec7487-0bbd-4044-7fab-08db941458d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 11:25:31.2885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QKrinyn7kcHOJ0xrm1v0NOKztJ6UeV/4nzgUp5bIyeDB9/xR7hB5RUZC2lFjKWbt7EayTIbJ37bgLd+gachoXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5856
Subject: [virtio-dev] RE: RE: RE: [RFC] virtio-net: support access and control the member
 devices


> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Thursday, August 3, 2023 4:48 PM
>=20
> In some of our cases this was required.
> I think this should be done by cvq.

Admin command is what is suitable for device management, including features=
 and configspace fields setup.
You can see in your patch that the whole group management infra needs to be=
 built on cvq.

In future, there can be a group management device which may not be the pare=
nt PF.
When virtio matures there, same admin command will work on such group manag=
ement device.
(for example for PF).

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

