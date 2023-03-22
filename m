Return-Path: <virtio-dev-return-11732-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46951C6FD1F
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 22:14:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5EFD46040F
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 22:14:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4BAED986495
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 22:14:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 416F9986460; Wed, 22 Mar 2023 22:14:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2E7A9986455;
	Wed, 22 Mar 2023 22:14:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/tjTR3UBmO3bCGXZ0ktpaRJPU3ZhhU/a7srJjkbYhP0UyuhBvUjM2iv3y/+MAcaK8trKA2hoab/knTQp3U3nloYVceEaKcKSMKEE93c5Mw5h0YHcrFZ6PsDUn+uqww6im76psyNcz70+fooaEj4xzwWBktwzCgW4CgJY+DFQ3ugDD2sIPXazOKS0j/aSdjZvgAtG3gNWEfJCyfxiwltBuaNiVhXEEc4L5PMYB3QCdu/D/y60DWNyJ9YjEMXj/XGZKdEmpUcJ0A4vDxl2ec2hPyIrMtITERAIHUbSsfQOeZFc49/OVhb/86ChLPoeA6HGspclIT4UmGzSYPT9vRB+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zs+ZCMj+6AgNg8TKMOt943ROmteynCGavBIlXFRy6xQ=;
 b=doKJcHD/0rEH3ZUNMAFMFGcwEjYv6A0Uz0xF5bHQ6ROns5YyQv2j6IYRSKdBQv1yy3KmuR4PY2Oninyk2i2Dp1F+68KmcG1tDQiuFGRlk2q72EeE4IiOkPYHa3OkbNZe+la/6RvtLmacMrHrcgfXwtBQKZ/mpErJ+cH/DJYcmBoOeTrNII5rn6oh7aJlmnK0RjMz7YBEsE6FSTenDMEV0JttQlQTnly4RvHbgfB1nZzoKUdEPFDF5haI5ukUd34q58MWtxdHT61ADdQYD3HF2ZO9dEi6+x59aVgoLmjaULhDhQjRoVbx4PRdMYnaga6UhvDR316YUzM+dB6e/fdeqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v3 8/8] virtio-net: Describe RSS using receive queue
 handle
Thread-Index:
 AQHZXEBhAOCcFxUsWUm/MA+nPP3zI68FzRqAgABGj4CAABWFgIAA3ubAgABBFICAABWPcA==
Date: Wed, 22 Mar 2023 22:14:38 +0000
Message-ID:
 <PH0PR12MB548134EF2C4A2707F28C234DDC869@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230321215834.225856-1-parav@nvidia.com>
 <20230321215834.225856-9-parav@nvidia.com>
 <20230321180052-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DD9C8A5D0B1B14A3B184DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230321233616-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548118C2FB6C986D945397CCDC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230322165542-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230322165542-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB6970:EE_
x-ms-office365-filtering-correlation-id: fb895da9-670b-4cd8-6616-08db2b22d3e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bQY3R+Sa8o2F6TmdgGxyTikpoF47CC8MtXCdAXm0n7vDtNACJUeXpHhLHyZzdH5uRhnIQcQ3pZP1TJVSU59y8spOB10CllC+kRlf5/OK7BblVxVw+gLwsilAr/NYjHIi7m/nGTWW8dkkE/YHi0w78MPXaEbypeck83n5Uy0amHar8fPHLfGWKmE9Pj2gKWi2otEgXmtdpJ7MU6/skOGYYYxTrJZgpv0vCtNxvPjxjhcc6B7n3iw0T6ZgVXwbPrkP1b7WC9UQJBaZRcLqStar8bY0aZli8es9S7onS8Cz+j6C/iETxR3uobLulMAPw3TqHWFdBISRVC8BiIjGWLPWTU8rOAekIo9sowEVdB31enMD5L4tgPhR7OuXGXtad9BRYB4hXYMDLv1TMmAId2gJSxR2lThn4aSjFZ3W6hhRouMhQCwxwz2xeuuKNf+Jz6qBerZg/n+l0n61HJBVzIDiY4g71Br+S2mGM7pKXjowWIBtVbBafBDZfcY44BuRZqOZ7K+cTRBuf0epCHPF8Df0hV5Jo1eNKOksO9cBkOc/ygGsBpNfWmwIbKMVMEu/La9hbSGvE4NRXaX3g7QGoLjnllvOK6b5Qw0BAzLzUq0ZK7TgKP9nhlxXeuP4FOR7+4TdZBpM2sz+anUJ5etbRbdtFCOFc+cZDk23om2+rs8RLbTariykarmaySqvOWsv+d7ThVGMkgGh4e6SLG4L1NSqZw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199018)(9686003)(5660300002)(38070700005)(26005)(8936002)(6506007)(55016003)(107886003)(122000001)(478600001)(66946007)(7696005)(6916009)(76116006)(66446008)(64756008)(8676002)(4326008)(52536014)(33656002)(66476007)(86362001)(2906002)(316002)(66556008)(54906003)(41300700001)(4744005)(38100700002)(71200400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?R7Vz1+Pn6mu2X65d5vbcusieHywK8XYmUpXzadtaSJAkTkkZmtYMxpcEU6F8?=
 =?us-ascii?Q?lXgmBhF4Tm0lRdtBfSHKgdW3kcc4iiKD5c/wqThFBBv2EWl7xjqBk7ZQvxyT?=
 =?us-ascii?Q?cHy8jWpqrst3JC1wE9hU3UUfvCJQ6+6CLL3IpidpM+NUv2JrvGX5LNiliZVb?=
 =?us-ascii?Q?cUgbPJI9gTocduwsHpHyMb8OcEaQFWOWOsAXECF3+s56QQsSkP8nSHO7QFjm?=
 =?us-ascii?Q?KF0qpFLkW6W/82apFhsK8yUVypXm8bg6l/DBsSvZgvNh7IGYML5A9Wysugw9?=
 =?us-ascii?Q?m0xhvzsbHUNyTeRfmsOgi3wjgEvKbInwG/YrDr/aJuBmV6NiYdsf1nDj+bBa?=
 =?us-ascii?Q?vLZdKSK2M7dDP3wsX/haE0nhTlImcibUaHQ6U7FXp2pGVVVrBRlcfZ+52iUB?=
 =?us-ascii?Q?0y7bMlFyZDRH3GMHka34D5qHKlBZUl76nJ6mxVBaNNuMq7IJkPVumwh19V+r?=
 =?us-ascii?Q?ZziO1QhD9GD0FoZze4cVCHkxtvbeE+wHi2w+8XmfuJ3hXAIhpluWwNqAJFTN?=
 =?us-ascii?Q?NpZcvv4EUIT+9udU3tCy3gqcMDtqcMes/H1ALqepNAsc8KcYMrQPPwe2u7RP?=
 =?us-ascii?Q?5ZChqcdbjIrCqKEkP7FSytXSaLoJZS9Jbbn7k8C1lwiBuBEW5eBymhk3iK2Q?=
 =?us-ascii?Q?J2ZhzLv26lsffeGFuuDNHCrjqdlPpDoOkX4kmBJeVVUJVR4leq4IBoOn21dQ?=
 =?us-ascii?Q?ufN70+qphLI0DdPsXT9xg1C0YxXpFaNLlv+goFH0ADp8jhpcZSxX8XH/iDm+?=
 =?us-ascii?Q?H5bL9I9g5cBElqPFkWPz+w5M+a4WypmDnCNpTCRrm9auDNqcIefB4g8xSt5Q?=
 =?us-ascii?Q?qnPPFe7LmiOa3IXxmmhCNky3iddcAeV/5Nxo7IVkRHrExcpHg/zJ8+LaRxZ+?=
 =?us-ascii?Q?L663mF++JV60UK9RVXmHyxlJVJPwlnif+CpoDHw8dWyyDasAIhyE64MknmNa?=
 =?us-ascii?Q?Wh2M25zfvqvyKzo4nuJsQKiMWJ/CRCN0Xnc8V54H0adyH12F21ghJH5UHx5H?=
 =?us-ascii?Q?w9TxL7XaHVtpInHkyLm0C13QfBOueG2uEOPMhMOlAiFKL674WYvWK04vkKXn?=
 =?us-ascii?Q?GXX50NHAYURkewE6MoGZ/gEgEniDLAqssqzCDSseSxlK8rUMhXFhfg7+/cCo?=
 =?us-ascii?Q?MpJC7xOtkh+oHwVn8ksG2AqBJc6n6Z8rZojmN52drP0kwc+AXpuwiRs58YdL?=
 =?us-ascii?Q?ja4v/s4ah9eXf95J8PZWug9ka9T2vkGMRA/377Dqpu+fYc6c9KFayipRU5W/?=
 =?us-ascii?Q?1Tc5Ov44rUi9us4zB6gv0veUYAYHXPFWyOpEPl19lcrVtQTWcmLAA/wZ+lR4?=
 =?us-ascii?Q?laDXjk8J+czJcrDXVd5IqlXwOXVyYW+0KUZyXYsQwfWgMtsnRAtgOIwE3HNB?=
 =?us-ascii?Q?8W7vOFDr1vD1X+TCVdQf3Kzb4HI5thY2Wdr/0DxzFiikmCsN9cCPcaUJOrwd?=
 =?us-ascii?Q?n9zJjat5k91uWY65OLLfriuiM74SqXHLRbffcA2FjDpUUCLQM09AutowPxy2?=
 =?us-ascii?Q?lfKFso/a3d9d5p5/h+W9Z0t4gg4y+KgWjofotId/Ma5u5g5p1LcuVtNDlwy6?=
 =?us-ascii?Q?Mx6mA4tzzaooUONGEJo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb895da9-670b-4cd8-6616-08db2b22d3e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 22:14:38.6275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mgGk69Ijpy3BUIYkLBzlCsRrCWV2iiF2nCmTqCfZDZVPEeKbUKxRfJ8bXHyorClsUDHChBRDFsEpDFhkWvKV/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970
Subject: [virtio-dev] RE: [PATCH v3 8/8] virtio-net: Describe RSS using receive queue
 handle



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, March 22, 2023 4:57 PM


> _id is ok. But don't define it separately as a special object, it's just =
the format of
> indirection_table and unclassified_queue.
> IOW define at point of 1st use.

Sounds good. Sent v4 with this change with rss_id next to rss_config struct=
.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

