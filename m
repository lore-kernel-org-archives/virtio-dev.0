Return-Path: <virtio-dev-return-12526-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8A2C77B75
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 20:06:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8BD2277E0
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 20:06:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 819FC9866C6
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 20:06:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 74D9D9865A1; Wed,  3 May 2023 20:06:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2DDA79865A3;
	Wed,  3 May 2023 20:05:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToSNtE2mYE/oa9aXsDI3vHXxaPx2FtJuTpPDfwEICDwiH8TxIRZUgu4UOYGlBkebbZKLWXCweHXZNzN2y9B+m1T6n6XdayGTv7ubf26Uv+ycmhQ7kTs9V31xJ4AmxbcICslK+YqsNflqJWBMKkUcvWJylAhPYIXlaAorU3Ot/UccU0Qn055U4aLp/0Kktn2C4PHvWNnJuHyJKdmV9f7CuP1jHwRU/s0LvqhyyQwcVxr1uJ6LYFYmFsttKGpM3E9axJO2wb8W24ReTapCS78IV4Zyu11E6bVc7JVCyJDFUuMz4HgR9bEi+9C7aCdsEtBrCEN66HeB7bQfIl0Js7diug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wM+kg7qAPSW3H2vZBohh5Ou7rVryw82QuMTkTCClU5A=;
 b=isnuYO7BA+Ym7UDt15X6BX5FlNl01213XvGkRqcPKIJ4+lJDay8flEOUNCvR8x3RXV28WfkWfMMYX/fjYM3bzD5Pwvqhehw0pNhzyh36pmyc7BvPuKHPX3aoAaEpYEZtlWL3AFYFahi+OOQRG9UH24NEE7pzTZX9Bme63lQaFDhvzYC1Aao6VFaX5J7dIQVgqOIduM/yvC9yolalnUf9/8lmSj4LHGhL3GhhHEAEhgt9RbVNALlhM8xCDqlyu2mnvxWoHeWY+VEk87BXEkSHv9uRsE7W8QPxPpfvFs75MKh++ZP38az5Re/h3scjgl6H4A38rpjSya8LuVu+zZwe+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: David Edmondson <david.edmondson@oracle.com>, "mst@redhat.com"
	<mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>
CC: "sgarzare@redhat.com" <sgarzare@redhat.com>, "pasic@linux.ibm.com"
	<pasic@linux.ibm.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] [PATCH v15 03/11] content: Rename confusing
 queue_notify_data and vqn names
Thread-Index: AQHZeYi+G39LFcpAhUOkVP5rbtRfoq9IZnQAgACbbkA=
Date: Wed, 3 May 2023 20:05:12 +0000
Message-ID:
 <PH0PR12MB5481603ED8A7A6C8CD50F401DC6C9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230428041949.411221-1-parav@nvidia.com>
 <20230428041949.411221-4-parav@nvidia.com> <m2ild9vggh.fsf@oracle.com>
In-Reply-To: <m2ild9vggh.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH0PR12MB7930:EE_
x-ms-office365-filtering-correlation-id: 36eb3dcf-76ac-4503-d4c3-08db4c11b420
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ricYRhby0fTvaLiLymcZsOydvcdU2rPKDpw9XsptGTLScpLk0zCwkmMLXCLhfrYOMVu54AkEIrNqtXOmQt5D1Biktcl2IaIAhHc07zu07YKuynH7A/VRYRmlYyHH0KyoRj6skAInS7w6lR3Wv095WxzN7LIQV+JB3LGPKkMAx8fY4fdbFOIwBVgWe+PAGUPUgc/QoHhBXYEYUMzZCuGoFq43U4AcOVq23rxeEiBsNTydCD6BgeoBtrwN+kN8YexYZOYKCprKQJkmir2e5Sjxd3RirmOJ8avMYWrUD7U3p6PKCL5btrBRpDl8wz6joUzLavsxfbQOZ4FDHsrfS30+L9THqQL7zkXD6EuEq/cs4uZJAiElvNca3J8+jvV5BjDp76WpJ8CI1mHWJ6OGJYwL/UieyHugG3atDB9M4Pjypx5Hyi+yjemg2+dRz/7OjfYJNRQ9rcV0A7FFOaE3y940crfcWdLQsbADH5yDbFhXGpOPugtGdlp0yt6oRQnFRw8nbwmLHRTLvy/dsvUCxQCU8ChIaMLw/xGlCDQAGO4oM2OO+vsvfJrsssyvL8t9oFOcM2Lk0Q4TMV9P/AA/r3bkgMYqz+05MYymXS3z+EGH6O4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199021)(7696005)(71200400001)(2906002)(38070700005)(55016003)(9686003)(6506007)(26005)(107886003)(186003)(558084003)(110136005)(478600001)(33656002)(54906003)(66476007)(122000001)(41300700001)(38100700002)(64756008)(76116006)(66446008)(66556008)(66946007)(316002)(8936002)(8676002)(52536014)(86362001)(4326008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MX7/eg4hYMbO+4vY++Rb3+fG6ZIG8NaHFUekl10zfDWXcec7iQiYu4b9xdPu?=
 =?us-ascii?Q?DH/CckVPi4Vewj5Eih9rRxP1H77yPIJRwUFhfQmZtEXfOz3YdeoFjD48wH8T?=
 =?us-ascii?Q?XrVrUlNXZBuwoNCR9y/8urjuzBSger7D96OAFxYzCJZteQymAiz1O6rDlY/6?=
 =?us-ascii?Q?JMmIfsLW5LEwjkwCatG0cfdQPtMK9K5Vd9+cba9CUsJsm0P/yKkC9oW1mkRM?=
 =?us-ascii?Q?MZgcafT4LYz0+Q7S6/e24vLuYg7VvAnNI1o1MP4uKlkUSRPPnn7FBoLBHbV5?=
 =?us-ascii?Q?KiV7JmvDUnIDTY4BbVzapZybEDP8FVFUfYY/rjxzlpd8EpgGt52VXzeLlHzB?=
 =?us-ascii?Q?vCsZtFcRj2rqzfFJP9X8384kVuMAN8bO5H4sCeYdyqz3XiLFz42EQKSC9J1h?=
 =?us-ascii?Q?wWU5hLwXj/hLlqg+2bLiDTFyyIyjaOqXJYEuucVIBSAFzJetgAVEpybm2ErS?=
 =?us-ascii?Q?Eycf1QOcbKP49JsCHhr3ueX3KYl6U/u8Wwjav7PJqDDwqTYs4af4DQ7ysvzp?=
 =?us-ascii?Q?Fh5k+wQb/BP19VbfZmb7zRQ26zI2KyuscQYq2JsIopJUNLU4GvTB950f/CR1?=
 =?us-ascii?Q?7ZJojYeLbLpxX6egs1UvR3wVNKIHL0vXmNkBq0/kn5PwR/vpZNFa2SKenYAS?=
 =?us-ascii?Q?6ZqTr9AAm39jVQso0cSgPxzr/5BUsjXZqmRbe6hx095VdmrdhlqOq4VbihWU?=
 =?us-ascii?Q?YazjBVYpKqFP+gO1rbCaeDrBSMF3b31DBA5X7TlfRdWp4rs3vKUeTo9/6qQ7?=
 =?us-ascii?Q?Hi1/Doe3NwbvxsDdtfQkGES8HFed8qJUoAFKzACItJQGzl4N53WJh5wu0uby?=
 =?us-ascii?Q?OYluL9xkrFPHR+ww1tWjD/iaBR33KqTsNNuXhIHVi48JH8f/lYcSG5YMeLgg?=
 =?us-ascii?Q?tWQbF6I/rWPiI8EoCtH4hpwrb/4YmsXq8rHVBv3ktvfN5+zlF6iPqDHzNlcq?=
 =?us-ascii?Q?G47LApUY+T6ab16PPYuzN9y2FnEiTvOBwgxKw4AGdzdnU0s+zIbBk2CkRy3b?=
 =?us-ascii?Q?xF/oGn2Qmi8UzrPX2eu67YS1GA6HjdugHo1ivcf8ax8tj6lJHYPOy7tjCnBz?=
 =?us-ascii?Q?0pq+XE7qvS+2SfQ/j3q/432Z4s8Ao4LDdZj59ArSkWIn8+AdUa9vr1u29kMj?=
 =?us-ascii?Q?2KzHjmxCSCi8ovPAyTUWNNsLnhCWDjA+smA5oR+rTO5SZNhm5bIKxZyMGiJ+?=
 =?us-ascii?Q?2U2/2cf3Q4lStZHHY8phPvCAzmJQhcdR0vNKvZReWvlVxDyEBkAhE7il2j/S?=
 =?us-ascii?Q?ma9BPGWBmUT9inUxbfwbHNN3rTRlFtLigE4V33eA3C2GPo+YhsAMP/2dK6sH?=
 =?us-ascii?Q?ruV7GCDJ2Zg6CZKoZmUgTZ0kOP80ytUAFZL26Ifna1H/VwNd54JK/kB1u9Nq?=
 =?us-ascii?Q?Gr/tAE5uixRgIPrKGK+zuLPm0btS2qVcs+fSXztVwo9ZNwdOe0+MlW9UtbO0?=
 =?us-ascii?Q?WrXEp1NWqrFmr++Bl1f+abVQpU+bbdlQLTvBNOz1vQPjFe3/r5XyRq5m7CRt?=
 =?us-ascii?Q?b07HOOirYt4L4Fh9/gNs9tlpt75P5hVcFhTYRtenRMhEQGNyByHD+V56BBdH?=
 =?us-ascii?Q?h4qg9Ej4HTfUthZLPKU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36eb3dcf-76ac-4503-d4c3-08db4c11b420
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 20:05:12.3034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2enShpQ6lA3vMLuHES52tpQwhEZd/tgIpzfV9fQgwb6cL3aLj+t6a6mMn5nd1TbiDyqXLGy/4vdhC+SRzEbUEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930
Subject: [virtio-dev] RE: [virtio-comment] [PATCH v15 03/11] content: Rename confusing
 queue_notify_data and vqn names


> From: David Edmondson <david.edmondson@oracle.com>
> Sent: Wednesday, May 3, 2023 6:48 AM

> Parav Pandit <parav@nvidia.com> writes:
>=20

[..]
Will fix all listed comments in the patch.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

