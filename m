Return-Path: <virtio-dev-return-11792-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F10AC76195
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:57:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C2C203E305
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:57:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BDF579864AD
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:57:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B3935986488; Mon, 27 Mar 2023 20:57:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9FDE2986318;
	Mon, 27 Mar 2023 20:56:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+zeKdoIEohaUCesygxN8kZrt/Jo3KZ0upqr6clg9Oege+Vepqbh7OmYsmWnfpflZCN217M8QlwkYQItTRKj91ova7erIilwKjObgl154zhGGt5XbGem/Z09+kUu2Xo7ZRycRWWi6Jlbhy0+g2rf1Ovbxa+7eZePnNP+MbDaM/ImhDbexvZyYfZXd4Xd9tdFUNPVtm0TPX7gJ19Ha9KCxcW2aF/9BRb3OUsLRjQ4XniSpi08tuPbC8hBOmNElI8T3SB8LZ6ynbhXmLUD96MiRbLg0iZfcccmox64ovwWeThsGlNhWsQi/aw9Dctw204zjXRma+GvoB6mPpfnKpQYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/E2fx7vGbmi+0Ic4bdIc1hP/rrk0SOuqcRilR++/yrs=;
 b=I/20HPcVUzKw9uhnB1yf/4i1r4ATRYCNoRbkPT20LwGFC0LkViwd5yeLlQxoJw3Oq2qprrEwHDUzLL3nGNF1UAonkztqNpOReAAt47SHa9dTggfy0LqB/ocwS0m1YUUjefz53t/hHyB63+HrZilBH2JvNQa7d88fNyv+1ErNChB66i7oUEXLL0caYp2OHjoeq+dpqONmMAvlecMfmqhFkWPwhNOrpJCyA886hbCbOEliquTmJKAKpXcYJHWDSbR+O2y3PbhKwQ8naDaxA5YpjaoXRWYjD1SN6rxiPa7Xet5IVkYUYHpe9avoNxPYMRZMRgds0MqWbRB80Rg45umbiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "pasic@linux.ibm.com"
	<pasic@linux.ibm.com>, "cohuck@redhat.com" <cohuck@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>, Stefano Garzarella <sgarzare@redhat.com>
Thread-Topic: [PATCH v7 4/8] transport-mmio: Refer to the vq by its number
Thread-Index: AQHZYO5RerPeqgXJT0Sqmu1jMCuoBK8PGttw
Date: Mon, 27 Mar 2023 20:56:53 +0000
Message-ID:
 <PH0PR12MB548122E4F3C6431CEF907074DC8B9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230327205359.406605-1-parav@nvidia.com>
 <20230327205359.406605-5-parav@nvidia.com>
In-Reply-To: <20230327205359.406605-5-parav@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA3PR12MB7922:EE_
x-ms-office365-filtering-correlation-id: cec71a46-e272-4633-e31a-08db2f05cb6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UDWocRC2HwCjdh+SbBKbtG9VytkSDfzX4pOOcUvUbEAuWLwUTyaZAr8SXSR2ofYnPiIbnIZFSXtg4iNyPemdH/+4+7Gsc8NsWNWtpL7CZEDmoj6QQZfw9rw7eUX64ft8MoQmaUZX5Kt27Q+Y7UlP8Yhfj+z7bBGMSy2i3/cG3VHicGa8H0Fu3afMQHpCPeAYf3LTi7BckDRVVK86i6whxxL3seh8C1SwtduOvbeVmJ90yeer/ZmEio+X8tONVY4yR+vJjB/zXcwiXyRNRY6smdFTaWXeRAIxEJFaDCYLLF+Qk1YV2+LoEFCWisVlK2RwZK4McOwz7zf9AkmgeT7i7CiPyhdsClkLWyDLA673LBDXaZyl5hZyUFvlF52zsQvXue+XUkVn4y757BoEPqiLPpy63Dmt93P+/Y/Ly9QNYuwke2VixhAglDTn1llHebVZlBnOwvlChNAU0aFZ2D4i7I5AuKsvQO4nGsOBRHVglCWrq2wo6Z5IvRAH+4IKRYLfXl47bCJeqMq5XKUd+8KCN7HgMxA60dpgYcJ/Hix8GhIg118MUOwCYk37vXeO9vhS4dbena0jLp2ik4D7wTm9RINAW8Zy2OxJLRUkp6IoTT/NdJ9rDl6vAcA8Hkzu49+f
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199021)(86362001)(55016003)(38070700005)(33656002)(2906002)(6506007)(186003)(9686003)(478600001)(41300700001)(110136005)(66476007)(76116006)(64756008)(4326008)(54906003)(66446008)(8676002)(5660300002)(66556008)(66946007)(4744005)(52536014)(8936002)(71200400001)(7696005)(53546011)(316002)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?861FmtPikb+DBL4Au8hZb8D3iTBuSSzfXev5yKo+LHJIYx8KuzqdR37UtmXi?=
 =?us-ascii?Q?Dixl2kINQzHLVtjaRcLxhxFQdaBPLaWi1AIxK5vqlIKVq+NvXez0v2IVzjfC?=
 =?us-ascii?Q?vlAxM2Bz0nbTCUe32FZVlxr3T0MDZML5Ks5KacSfJPnE9dG/DZmCkJN1tYK6?=
 =?us-ascii?Q?c2QefejkwzfQx6gMWUUpgX25XSzRPQ8y3MekKbP5l2iK1glGFKIl+ZQK1kL6?=
 =?us-ascii?Q?qM4EJiTuTghRGwXCQ5hj0tABiXEtNd284h7bYaFUhMtMHSxTXzs89A6bYgdU?=
 =?us-ascii?Q?NlwHGezIO5NhAkwcNk9/IGnv9765fIrn5ebYMHM+AEr7opyJYLyVxcDfsSLq?=
 =?us-ascii?Q?mSYcCCAvPa/8Cb2A/k6u7K4IUXasOKwyl/U2PpmWyL6Qwu7BaYrNoWwTjkdm?=
 =?us-ascii?Q?g8U7CVR4cRC6iZhnre9xxulWvRvfDmGS8LvsvKkOHc6pnsyblahS+G/oQdK9?=
 =?us-ascii?Q?Yv5pavgpMzPEpZnsnmFRiZPwZOWFe4V1Qb0+Y/w/40/rNIe7lXP2Df3iucHa?=
 =?us-ascii?Q?taiBhjzMLa/mA8EtM0kbYsLs+f+dGPz2hhabz6JbtrSvtnZpdyLfjGK4nNZ9?=
 =?us-ascii?Q?vgXrXxNRDobynuqYdRCxmuvZaLVNavG1cl7FhlbNb8zp0gdhjo0QZR+ruX/c?=
 =?us-ascii?Q?Nas4DSslkE4tHgoQlBQin1LfV34TN/tLHwfsJyDTkF7s2SuXag2fH+GM4Poy?=
 =?us-ascii?Q?Vl0Elsa8alEdALQWEqW/AkC5d5gN5emOEW7G6GM/I5vUZi6RPruIc4IIYW03?=
 =?us-ascii?Q?qD690CTF7T14I46xs4nVxuwNOepPH3sreLKkwCkYCi6LZoaTZWlKERTlqVCC?=
 =?us-ascii?Q?wEEfJlpmrf8nBM2zoCj7jshTK0433HV2roRfY1iYoiGH1Pi3fvH1s8QqYIHs?=
 =?us-ascii?Q?OJzvztVwl9oSiF851r31b8ogG+d/PMkwe+qFA1OtjAizqcY0iORSM3+Wfmni?=
 =?us-ascii?Q?ldLCQ+pwBIYEfUMAsQM1BwwOj2ZkQuS75rYW9FSBWRMlmlscfNLL5ENPfmeb?=
 =?us-ascii?Q?iRwnZFWeUKjrhZer0PQZ9fOqx9s+shDzebyXh8slJ5kuaftlTqF6PE0GOb9f?=
 =?us-ascii?Q?dewliNZYCcF4/Jr4XlSQ44vbDY2R3Aqom5DuITx096uBuZw5KbGdj71jID9H?=
 =?us-ascii?Q?Q1k+1bS/LTCXHTTGIrIsobdL4C2WyUopnUFe42q6uCp8KpdaSNZgNhKgPb6L?=
 =?us-ascii?Q?5MefIzY7NQJo12Qr8i+yXjenwsXgwHWtz3oqQUU7JX9140WPZZfrLBiCxjem?=
 =?us-ascii?Q?SMLrowlCYlL1/VeXhXF0Jv4zFXlXAboxS/8H0qsjvAJCAocwHCBzO5S1WgA+?=
 =?us-ascii?Q?02wqy3bwPdLaPV+uiwzfF1DrN0E0nRzIzTR7A2aLw47Kxki397bn7O0Esyod?=
 =?us-ascii?Q?pBYGmKbJvrjfYtQlnYTvxO3CMij7ac+DzeYloPkSoZD6nArhdBoBDLmQbJs6?=
 =?us-ascii?Q?YAv49cok8/i/Mm6ZYStuDt7sKFRqwzsVba6hTIMMLWa5Qj1suS/qd/lhYCUU?=
 =?us-ascii?Q?kakjyh3XgVfwLQidLaQgn5BRVFnmq4Sc3TQG7U3c2NuZfZtxVNv4A+OHAEly?=
 =?us-ascii?Q?34pSSj7ZTDXFGgRIHTpCIiZwzEvJg3KXxILUtwu4Eu05m13luPjDYIvJZoUx?=
 =?us-ascii?Q?hOo8iTdoLF0gfMCIMj933Bg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec71a46-e272-4633-e31a-08db2f05cb6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 20:56:53.6554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x5Fq/GJga1614FyTIDNtRkx54C4PMQt5F0JvpXsyrmf+iYTqq9lvQUu7YRXyv8QmKKw56zJaFReUqPKxDk2xFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7922
Subject: [virtio-dev] RE: [PATCH v7 4/8] transport-mmio: Refer to the vq by its number

+ Stefano=20

> From: Parav Pandit <parav@nvidia.com>
> Sent: Monday, March 27, 2023 4:54 PM
> To: mst@redhat.com; virtio-dev@lists.oasis-open.org; pasic@linux.ibm.com;
> cohuck@redhat.com
> Cc: virtio-comment@lists.oasis-open.org; Shahaf Shuler <shahafs@nvidia.co=
m>;
> Parav Pandit <parav@nvidia.com>; Jiri Pirko <jiri@nvidia.com>
> Subject: [PATCH v7 4/8] transport-mmio: Refer to the vq by its number

While using my old send script, I missed to include you.
I am sorry about it.
Will take care next time to add you.

Please review.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

