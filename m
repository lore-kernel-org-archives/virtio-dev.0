Return-Path: <virtio-dev-return-13026-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5DCEB64D7
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:25:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9F87188E07
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:25:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8668C9865D5
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:25:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 77E99983DDB; Wed, 21 Jun 2023 20:25:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 646BC9865CE;
	Wed, 21 Jun 2023 20:24:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlp6MEdkiKxIBsbql9BRXwYka6L/K9GEvaAFFstRZiS0DMRiqqEYiUCfIEV3OxsCz1h4YoF50yfLrZh+jT1KWg2uEa3A3ZXutfUgIft6pg7Pf94AS2trIqYt9pnOWbONUyme5pWeDh/VRJiVOWkZg0XsdEuT6yqOoBvaM4FrhomoWk2jpLzs24dAdPkiHGUOIaVIGcQSJ3Fp/vpj6w0viw+9up2AoHRMnCOD2GT8ii8ps+SAH95DP4YoyuK2J4LBTvp1WnobRSQ4dE+gqp4btgSRFu/hoJUaNlj9K+UZu9th9i4PWdqSglZ7VQnqciGSX9OQJqYI+TdHrs43dXMesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2I4HtuvJoJCHofe7rsMVg1Zy+43gV7gy3isYS/NdE4=;
 b=D1zsGA/kjY7TBFrk1Ln6MYrriTBwDz4AzfdkuO7D4ZGkOV5jNjfFRDPpGpxpmit1J1GtI1Bb53fHAqrLJEk4DEkv3vbIWioGBTfAyqlBO026A07dmufUNJSov2GaHldbDDjj+oYCJ/pcr9K2NNyHKtRYDXKefRZQ/RUXSHqnM6G514G35WPp4iW+FmNbWxKphbjCQlFGNityLenV+QhsFVSSHwOpvvUIAYTqniaCCJtjv3nJ7FJDsC0Kh/qa1dTsxoiZdqtr3V1/irtKp8T9T41gBPbsZYjU/b2OlwHaYo9pKaCHhu0BbbsKMGMae5xI9sjLN221BzmOBdQP9ntMzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>
Thread-Topic: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash
Thread-Index:
 AQHZpEdpSlZ4I0eUeUmZIFkjtAkw3q+VZGYAgAASyQCAAC5zgIAAADyAgAAMJYCAAAHeEA==
Date: Wed, 21 Jun 2023 20:24:57 +0000
Message-ID:
 <PH0PR12MB5481C99B8504F02D39B3A6F0DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230621135052.76028-1-hengqi@linux.alibaba.com>
 <20230621104647-mutt-send-email-mst@kernel.org>
 <20230621164606.GI74977@h68b04307.sqa.eu95>
 <20230621152559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481141E18AAF1BF214A0E29DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621161157-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230621161157-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB7737:EE_
x-ms-office365-filtering-correlation-id: 46a69c38-88a6-46c5-d885-08db729594c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 spFcJc6RLXyBYZjJlEwPwmUTFEVSCK731JJSDQmpYsWR3jdVhWv6pIWCcn8oSRIvrivs2vBoCKauyAGoR+xYg8s7UE1eQrt92jB2I+GO9zOFeMnjyfMsAgi0UlgjroT1Ei8f4f0B3QmWEQKlRg0Hc6Zgc0UMCP+IxxBvpXO67uch1aMc8XcX4qXy7yur4YXoqEpi/lujIVZUU36YgqNcmlil6rxB8YJNIX8CstvRWiG9Lz2nNc7EU4HR/H/xjKUQe1qibm9hz4L0hnhThROHK2mHJ7z/T0U2EEWIol9lfIJo3KiLlbVNKNWpyxxlwj5Die5bcO75fnLAsrMD4axkW2NQOYq0nmE4Lwe8lzqJDYmT38MzjgM1UKKIpbwWUTkhWS4+51S3BNXXCPqSBUVVIRLmun1PISmVKlkBNLe9GmUQVOUnBsAaEbKU2+M97AZ1fj0/D1wmg1crmsLu3UP2g3GTNqnipVt2Y0Z7lTu1MYS8whShheLAs+BtxGl+1klrIdYmXXkXTOm4QLkHELHkS9gk4/LzC+D7YoitwQPexWhoUT2vHZwozCqEtjTQfPe+tpOTJrok6Zo9fKLwlUk5E1U2mXDDdJgAtDXGJxOb1GRC7549Wqk4kihn++8s2n94
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(122000001)(38100700002)(55016003)(83380400001)(6506007)(186003)(9686003)(4744005)(5660300002)(8936002)(8676002)(41300700001)(2906002)(4326008)(52536014)(38070700005)(71200400001)(33656002)(478600001)(76116006)(66446008)(66946007)(7696005)(64756008)(66556008)(66476007)(6916009)(54906003)(316002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ABpXWTYA/qiMX5uK3sMehB528yyAImzbmJasfwxtDa7OWUQ45GschXEZu+kI?=
 =?us-ascii?Q?n/QIIQSbe5whKzfCDhJPUCRgGwvjwFBwgSh89YUw8DVOwBe7kjc4MIPh+bzJ?=
 =?us-ascii?Q?+FEIdwkLelOEku7NZ7HGNFFsfPqdQvKJndpCtDSXmC2aTXlqtPZhpBI4XB21?=
 =?us-ascii?Q?hpd/D333OwYN/XJw7/Cfl2Wr9sJmPHFORhcYLoxt7MVLoVT/dOCoSeNSd+Qu?=
 =?us-ascii?Q?dtW4kkesN+MAK0enYI/dc19PNgSdIjBJRnF/MZIPItHzJQzqx/qdJ1rmUXA2?=
 =?us-ascii?Q?3x1DUsHa/0NqjoQdQCtwcOZtEqy1+URGTzv9/GHXWSJLStLxULJtlkszMv9s?=
 =?us-ascii?Q?RcGC6SR++KfuJlp2EsuC76iuGGfksL7OUJhOCzkps/H6u+LEcX/F3y3RzhMZ?=
 =?us-ascii?Q?v+QZFQPkMPPcdtGgabvxa1ctIzAyYSDGx5TvXPVggkW+jdHIpKkXZzdQW0Ku?=
 =?us-ascii?Q?Ch9MZBwW46tVB5vCP33FmEIKCvZIY8bqk8+WEpQxUEov1lS//yQnEaMlEJtF?=
 =?us-ascii?Q?kvm6itVoql9IbBcWe+eZ8bZsLSd81NVq1SqYlHOrJn83erKlrRyBoETjq6bC?=
 =?us-ascii?Q?3PEead/gxOHkwQJLXUjh5A01VE8V4AnoKOZY3wmmKSCwShzVh/qn4hiwB4Di?=
 =?us-ascii?Q?0OKDtcPR+xrG9Bpl/vGAm0qBA5T6/vgQqnCXTwiXxJ/XgpegNTd59AIlVt39?=
 =?us-ascii?Q?rEWR9UPG14lV8i0lXSmhjlueZz6gu9gCYjop0/5ebBsGt/X3snrG0gJIR/1h?=
 =?us-ascii?Q?Vi05skMuJetnpsTl2ql+D9GcCP8F+xL9BKPC7/7FzY/g7zvaxSVG1YP3PA2i?=
 =?us-ascii?Q?qahr4zmfJ0EZt9gYfll6WQDEUu5Z87JFTfGCS3Md0p4dLUtAnSMEpXXnpH8+?=
 =?us-ascii?Q?JICwlA+EXCFM00jfbaS47uS69x2EfqdmyhswFsRy1vFEaTrgXwwZBZpFyoCD?=
 =?us-ascii?Q?BZp3GoW4+H9c6r6XrDrXEa/XjEL8WkoV7Db0/MRKG6yCcQCFgS95mTy/PlZK?=
 =?us-ascii?Q?nAdwcs/HLOyCZw14xw9ABInj3ERrbfR+R7upXd+rC2M2cyLzUD5YooxWRRHd?=
 =?us-ascii?Q?pjRA5A1XTuzYQAW14kHLIZJwRwuC9IipyIlCitL5KXQJ6qdFBaY7khBTpbAq?=
 =?us-ascii?Q?oHK1WzZYm0ukxZ4BcKdGNZ/bWX7Yis6ShO7ZfAKrdddBjU21aCfPxQkzIV1g?=
 =?us-ascii?Q?EIXL5M9a9PmctYCy6LYFZkiyInLJcC6wP164C8VOv9m3Q4/kryN6VSlsrUt5?=
 =?us-ascii?Q?3JRaFj6kN3rn0kAMreQJa1oZ695bss/KrEYuAtl9s/3UY6KSSC0FS8KYvcUY?=
 =?us-ascii?Q?L5AM5kac1Xg1vj5lUTLrU+ATjNlDJaKuQDwooMJWAdGHbLLPe7pgbjB3BWcd?=
 =?us-ascii?Q?j4dLFBLSbgh5weep7nA3+15tt16SlhRO1YQS3XBwkvd6wdggTlmn3sy0AL8s?=
 =?us-ascii?Q?6rrBl2CK8l3MfDxft6v+BIUOfz9UqEXKqfEGpc72mxfJjc+AruAD02M5FdrJ?=
 =?us-ascii?Q?pWtb7doP0qXx8PjbaWGstzmbKXUynhhXUVu4uyq/8A2lhNX1VNhVIcDveIq8?=
 =?us-ascii?Q?xv3R607QoBO4lXNXlKt7dRNt/g+CssuS+EsnDqRzToF4ssVo9tRtAvcJPOdv?=
 =?us-ascii?Q?qjiXLYkGCGewAtjgG6fhi8E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a69c38-88a6-46c5-d885-08db729594c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 20:24:57.4346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DPpFAz2aThtbpFI60++iKJRERmpavlMW/HDkeEJnbgbViPYEoopTU5hp6NUVSRoACk8Zq9nNrIdHpNqtivPH7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7737
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v18] virtio-net: support inner header
 hash



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, June 21, 2023 4:17 PM

>=20
> and actually I missed the fact that instead of making this symmetric it f=
orced
> separate structures for GET and SET.
>=20
> If we move supported_tunnel_hash_types back to config space then GET and
> SET just need the active bitmap. *that* seems symmetric to me.
>=20
> And the field is RO so no memory cost to exposing it in all VFs.
Two structures do not bring the asymmetry.
Accessing current and enabled fields via two different mechanism is bringin=
g the asymmetry.

So we do not prefer to keep growing the config space anymore, hence GET is =
the right approach to me.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

