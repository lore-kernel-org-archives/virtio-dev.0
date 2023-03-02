Return-Path: <virtio-dev-return-11388-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89653C678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 18:41:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F0CD96848C
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 18:40:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E8AAF98679F
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 18:40:59 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DDCF498678C; Thu,  2 Mar 2023 18:40:59 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CC03C98669E;
	Thu,  2 Mar 2023 18:40:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yy015ojFgZTAU40GjoJxOpzWzba3hClo6aA5vLIW1nHX/KpqTivSsUHHQhwgXvcHNs8aGeMT5XGP8WZMj8suHb/qAKuogqBLmg+aVzhC69x8XRne9xYdkisY1yrko1/pghAiASAkvPUqPpghbLs7fibYFCo4JADOjjDI3YRvmVkPoMVpGTrsux5SyRJKBhRPQuTymd92iFunitmT47aqowpg+21D6M6kslPelZS6fhiYCBcWieuiQ9fLJ6eCwmRdr1LPwsw1yPyt/kuzlUnS3+XhZSXGWyMZvDO1JEuAWF5t+BCav1+PDy5SbA4s757CDnO/QEWD/5XxDJa6VltHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZ3Enkzmfjt6xwBJUZBfTRdtFs/bMcov2UAULnMltMc=;
 b=iSCecwq1TaTbCGc5/pIFLTl8/Uj4iLVjEhkONcFv3qDhIQLwE22/Cb7k2EK5UP826POi6UVFalZBcSRUxFIrsBdfX/I+w04FASoKkwv9tomboKrkO6joclcrddwOpQoLkRCz5637oII7fckkW4JAON/RGlbrfEz/2cUkAtQmAZdFf7xRSN0cx93bARXgyHniXVOSVQYIEAkrTuoKL0civ/miui5ku6TRg0acuTR+7+bS73SwGp7+4TliH8MpmsZAQes8uB+8kPs2HValk6sn7KGO8CXR7f2vUyWrhK7HGs9HH2Dq1GxZe1yHSQZc49Gn8rI3NN/+2X1+Erily215ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com"
	<nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>
CC: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf
 Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [PATCH v10 06/10] mmio: document ADMIN_VQ as reserved
Thread-Index: AQHZTQelIthVWRw0HU6AQhgBU7+T767n0VLQ
Date: Thu, 2 Mar 2023 18:40:55 +0000
Message-ID:
 <PH0PR12MB5481595368C8F0C0E16B681BDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1677761896.git.mst@redhat.com>
 <dd9c34ed74ee296228562f6946d4ca3f2fbee1e1.1677761896.git.mst@redhat.com>
In-Reply-To:
 <dd9c34ed74ee296228562f6946d4ca3f2fbee1e1.1677761896.git.mst@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5335:EE_
x-ms-office365-filtering-correlation-id: 300c69c5-f09c-4256-23a8-08db1b4da835
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Tpzb3XzhQ+wZVXzZGDphGTKCfgnvh1RjfYTxSPwFE+9LkW4CskslX38AdLfVdmTcZ9luzGAa+KGJ2yjmBbYtcZ9/+yBGFM3E2tidLkc85qIRUKBCFrVNM/i4F53trMA1fCMmooTdZj462OuHc5IaB0maEsT/Ftkl8DiCX/LaU7rNu3pLXtA42Vjd5hAx/DWfDeqv2i0v1NdNxsJRql+lF8ifw+U/1A5mhjUH+GAFd+TAzqmsfmbLjmeKQcqg8PHudhHljiQ0A0rJBQ/tjor26V5IJ1pIemU+EVTDe2lI2A2+wPZdI+/vMrJqahMufza3RIQ33BIosbpMJb7AW04JNhnS8T7JdFYWMKPbEFVOZcPmsS1qQWkVKK8YmFAsE3hg3Mjsi7KANbnS0PhrAJEBYawiO8u2ls0VpiAdmy4OMWh4/WB0K4HcwB15Q4pzc07TjreQepEB6bhNc5+bRwQyKjB48INJArjwW9/0cMTczNfTH6eJS9yfyDatpESVuWTjcU2+wd7f0jzHcdyq1s2WbbgnKwXtGBR0YSmTjzD8UKjBZnY+B5j4ViVpd+mJhczvdaQfBS7kVXZDsTcBUQz/1Uu3YYB0B4dCw76PyR+FyG73hUv0dIONM2NgQexHRyfXgki8Invt/5uJ8wswUl8xI2t1dRXLcAmMkQ/ToIQM1etm8wUNokdgRb4sZLWw/7eNJJ3flLnPuKO4L+UDPgCD+uLCiGWdbDuhUOF/qDuou1q8FAE8wccTwONs9dCxzVrz
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199018)(107886003)(38100700002)(122000001)(5660300002)(52536014)(478600001)(7416002)(921005)(66556008)(86362001)(33656002)(38070700005)(55016003)(8936002)(186003)(9686003)(26005)(6506007)(71200400001)(966005)(66476007)(64756008)(4744005)(2906002)(7696005)(66946007)(66446008)(76116006)(8676002)(4326008)(41300700001)(316002)(110136005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RolMSZud+tGxZeKsj9ZU30Bn2oZ5hN7iXuJ2R3EsT2k2of0QCBAMu6ybNke+?=
 =?us-ascii?Q?hvIFgecdlfrcGs3O9m6LkZ77kohyVCrtVpZhYilukXzJrJLbSEb50K1Et0N/?=
 =?us-ascii?Q?SqJAQwR6ooJ/ebvPB8XYBqoFKYQNTobtNceaVh77FgDpz1C/SJk3MN5bbPtE?=
 =?us-ascii?Q?q1A6+7lKdkH+DkRyCX1TL53DydqSQvJ7NuY8imL7XhC5GO94g7CBSv8sevR8?=
 =?us-ascii?Q?vHikvc4JnQ+iCN5J5Wh5HxuGpS6zp/q65xkwib3+ea7vuUMidc5LLHTcNqpL?=
 =?us-ascii?Q?BEHER85wBw6NM6J0ilF6bBoQbzeb65Uj59t0LJaT/s5xvjSLicwZjJZYwiyy?=
 =?us-ascii?Q?Dd7HEZ6CBSD3/zfJRwA3pCXn9+i1tDjNTCi+d5ZlbqAv3NnZE/PJclaUJy/4?=
 =?us-ascii?Q?fsAgaHnv04sInmHkzrBKCG2nxGP1lucTpWKad6n6afMMDyi5BsAjDS9qnz1s?=
 =?us-ascii?Q?pY/eLVSUQfSKlPa6LW2OHnh2VNpGOfonKKdto7nR3aL46tNelCPSNHNh3hao?=
 =?us-ascii?Q?yhHfCL49rNtURP41qnQAM+hf4gwqRryAk2wedfnBuX8WSvF6pZpJuECkgeQ5?=
 =?us-ascii?Q?beNXdRSan1UfUqTjeDsjl6Jz8ArrWUQv1lbG4L5O2pEPbgEdpohF/MSvbYaZ?=
 =?us-ascii?Q?yV2MESxoRxJqMLSeMplqOaqiGFuhFc+B+BJZbLDPXVq70OI9Q96BWtncAyyQ?=
 =?us-ascii?Q?j85xuIf7rHodNXWpHJpgD/tInLFqrB4Qu3gbhkEsQJVy9tY288AjDY8vUpeV?=
 =?us-ascii?Q?cLKmXAOT5DMyFXBX/bTiscF+uDpiYPUoA0wGHy7kRcQBK1fZTne5YGhm1BSH?=
 =?us-ascii?Q?e3WY1r16NsKBWsmM2eD9QfqYLYrn6OYM18fpj0JcYKZ2xzl9G1AWXXDhPWjy?=
 =?us-ascii?Q?0QwJ+j7ATLo6osjbPLfzxev9lvGQfoKvdEt0rIx6r43cMI/zOa+Cb6xkhAr3?=
 =?us-ascii?Q?tQvrVJpDv2NRCIm5RodV3s5Emxp2Y/ok0ySWbhiq8PE9EpMD/DQbfs5mKW1b?=
 =?us-ascii?Q?hHLtqm8bazFTYvaBU9MciGRGYTDKeKxijaPnmGJbEI2CbHZoLX57EnZHE1Fk?=
 =?us-ascii?Q?x3JH3pEMJ/DF1HEJ2f+GPRIxsb1a4YnBRWEYkcvHdLLmjTyaZ48et/Gzuvb8?=
 =?us-ascii?Q?SufOHxnygmxyQlO01tSq/96e61cI0a26N30tATsdom3ZvADs7HFZ1kCSJxfF?=
 =?us-ascii?Q?m4GOwR86xabLq+5kBuS0zM3M2Sh4Cow84PHu7XDpsGREcxjw3y1iL89gE09/?=
 =?us-ascii?Q?SKJqh1RkJMES76UzIceu4aMpsFcIgrRomuRpe2505hc8R6hEC/tDVcG9kt2U?=
 =?us-ascii?Q?oDsPB8xqDN38kdVnsarc+68WlX5adFXnX+FwKxaFH+K84J2BnC6rAyP+Tp0I?=
 =?us-ascii?Q?x24Uv4+6C8aI0AmIKgyG6i2FlCBxgmJ0Km9wI9g0eS0cHMFUzbe99wyuLlDe?=
 =?us-ascii?Q?BVi+9B25nDvFudB2gJ8Y3nygsNqEjBpK8J9FhwXSLyknH0m0g0qIkL2/QK+J?=
 =?us-ascii?Q?v8wWA9m2ENeLqlFPbbpIk7DhB4EhMr0Haf0/kBugCX4KCWm1iwRaZzcApKPo?=
 =?us-ascii?Q?1UPj/icXqcZKNkfEmq8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300c69c5-f09c-4256-23a8-08db1b4da835
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 18:40:55.1387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erZiDlfBShLwOb8WoJLJeVhc6bU/QGALkEja2HqkJmmuJ6++6su/qmJ9aelWvvB/v/zQ/QOz4XcBJbxRjfKmqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5335
Subject: [virtio-dev] RE: [PATCH v10 06/10] mmio: document ADMIN_VQ as reserved


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, March 2, 2023 8:05 AM
>=20
> Adding relevant registers needs more work and it's not clear what the use=
-case
> will be as currently only the PCI transport is supported. But let's keep =
the door
> open on this.
> We already say it's reserved in a central place, but it does not hurt to =
remind
> implementers to mask it.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Did you miss reviewed-by from [1] or this is an old series reposted?
[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00242.html

I will wait for your response before reviewing more, as I am confused now b=
etween missing items of v10 of Feb and March.

Can you please have the per-patch change log? I learnt and practice that fr=
om netdev community.
It has been very useful to have effective reviews (especially when series i=
s long).

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

