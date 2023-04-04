Return-Path: <virtio-dev-return-11977-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441AEC6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 16:11:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EC5D029FC2
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 16:11:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C60DF986596
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 16:11:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B8917986524; Tue,  4 Apr 2023 16:11:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A4887986583;
	Tue,  4 Apr 2023 16:11:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTKaB9lhB17JbZxImMyDvaDpIXMsL8G4Uw0JhY2QFpm/MjVNrulBSPnDMBMIn03SX2SG94+osbUqdTyRESq4RQ8zB6ChUbL+eCundwMhPdiQjmipqxMktFo700pSA7lmBHXjAPr1x73fM7k43lU9pGBQaJ93nScC0ia5JFPjrJeoal4MEIi82YUpn4DC3Fjh7J3ryORsMz93jhXoy3+cH2UTYpjDHAdKO/NMIF3LUmwG2uBxzKukXY0iIElakgp3U4m8xT6bm2x/WGm6K5nLilSE1JrFndIloobkfS45/Ig79fYBSpVl3XMcHla74I3aTKmh32UYBtzcsMqky+23OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlScfrg5L+PLp3al/A7BnnSVgoBp958i9IQYSjcb94k=;
 b=gIAPU/lEQJgQileSYi8LbR2RskNhkNIC4ziPoCktmBp/ulK6BmnYfG0p8iXQeCcOof781Ip0YRQSx8eAPjE8ArDIrm2twyv2m8gsi79EpZcIXMo+BrZ/ehmGW/buqOHrtuTtsZLFWdH6qKXFfJVFI1ab1MMOAhecXoDm47hxUUcHMij5uG15hp/I4s9hwo/vc0UNI15H0YOPz7hIP6h1Ej3xwkqlijfddCytOgYu5HnoNNbIflxLT6Figli4xk7IQD25Pb6MLOqysa5gEr2lNA0Z/YYfotFAHyUg49mRHcgBP/tI2GnkLNiGZyrVAIoQNuEMHjtn/Wp43dSa1t/8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>
CC: "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] RE: [PATCH v10 8/8] virtio-net: Describe RSS
 using rss rq id
Thread-Index: AQHZYoTN5bnvBuMC502wSQ6/nKf6wK8TC78AgAclg2CAAKTeAIAAhJCw
Date: Tue, 4 Apr 2023 16:11:18 +0000
Message-ID:
 <PH0PR12MB5481151AB047FB6335ADF9F4DC939@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230329212341.465843-1-parav@nvidia.com>
 <20230329212341.465843-9-parav@nvidia.com> <87tty2fvjj.fsf@redhat.com>
 <PH0PR12MB54816C0F0759AAD5E9C76604DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87edp0jc6l.fsf@redhat.com>
In-Reply-To: <87edp0jc6l.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM8PR12MB5479:EE_
x-ms-office365-filtering-correlation-id: abf7773b-a827-4e10-236c-08db3527394f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WmFcWR/QU1B77Jiu1sLxzj8R2+dQICW5sfzfcwTm/Vr3T29vxQ9JraxKJ4BIHjWjGZ0VWCvCfLmokWanl8TA6JLs315oc/Pxsk19nFC6WSf+fr1D5WZeixX24xa2YzU4dbOKh8nLHJ//aeFqVMedk7cMysRnggbRrwvbuss16KPa5D3Sq7csZfY3Y7yhXnHVsWkhf0WVvZe+RaX2LMxyAOuxHRp+01nmbNMkfqm6SXUEkVQjVnzz90f/JJsEumIXOFMNXcxj8zQHpISP1U4Rk0uF1iFd/2cnXB9orgJR6oH3W8QFASgtd8AqdW7nrVbd2cRXCHUbT6Ja3FWb54oYBM4NrAF9O3rOXBAZZngU69dopFQdgAm0xH9GpH244gDULTA+bXvtFDsT0xCTzH5kQ5+aJ549s/BlqdW4xyFw57rVVZcZgHt56r9wCyM4prIKc+9UTjH7uLGCUaAbqB+17mDytpiQ7kjSrX+mad8e5dE9MqZFrpOvlqrtledtb1rdDNKfC2wUtCNEDSzOIdAkOQ6rRD74ifb5VPp/AZDyfzKTc1u1qVw77J71bF9q+y21ISEqmB7uh07ewRb5kqQg+5VH2mIirMazZwlT/DBifWSa12ybOFKwsm1UFGt/enui
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(86362001)(38070700005)(33656002)(2906002)(55016003)(71200400001)(7696005)(186003)(83380400001)(26005)(6506007)(9686003)(107886003)(4326008)(8676002)(41300700001)(64756008)(66446008)(66946007)(66556008)(478600001)(66476007)(122000001)(76116006)(5660300002)(38100700002)(4744005)(110136005)(316002)(8936002)(54906003)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pSMKtdK5NCNZheaM89zDogVM4UU9fgO1+0q6p81BmX33vTqqZ7t+V8TY1Wg7?=
 =?us-ascii?Q?D3cNj8ld5z3kFWNDDfdxjKlA9s8xD06ju+S2+dvrjHAKbenxXl/nK/G9fONh?=
 =?us-ascii?Q?OfVD76ejkhrdJmDpz/6JBmopj0pl5+V2HHyLKjQaUqYk8O3Ffd/mn2yr81UN?=
 =?us-ascii?Q?ltzN51PXn6+CwST4F6ClJg+11Ah6oThtr+ePCFxlRFh8xe5QmMrz/YMvpw/v?=
 =?us-ascii?Q?20K3KSW9h73uFpi7hyahRtbk24Mp1QYDUSFi5OgxJlA6Ah0d4sMiCIMIXuoJ?=
 =?us-ascii?Q?GMc7B51iTueBTnUT2JS0ENZwzgeHzFisDXfibNu6xGhd9lAz5iobkEyMMC0+?=
 =?us-ascii?Q?Un6aFrG6/Epozk/uIXk4iNixEBj6NmuS8U1bkyFhXSPZItTwLqMw9humfxv3?=
 =?us-ascii?Q?pKbpTQ02fCYOFXgLGr21jHMBDdOd1wg89WBiFSS/gZtbx6JK2vt0rP+GLF95?=
 =?us-ascii?Q?IQbE7/Rdpeag43R0S9ShOnAya+u+2yP1RWgf7eSfPfFSzNKRnxuVz6+D3Sbi?=
 =?us-ascii?Q?EAgniFoBUfAow4cE+deLD3exnZ0xSsRKe4J3d4gI7+75mPy/P+yrqbrHpkYL?=
 =?us-ascii?Q?3gf/9Ch7urqw9ieEZb3P3UodiVMxIPzSRzT3AjOtJ6IY3zdAZqdrqMEYwvV2?=
 =?us-ascii?Q?+Q06OO+QYkhpzHHLVwb0uIP8cpcMy3RpP1udYa7epDOYSOM0wsEmfqexuGk6?=
 =?us-ascii?Q?+c7mlkd3f+KroQf3pmmbiIVZabv8SWNaxa5uWUYHNzTLdeIdm6PbAUHRu+wO?=
 =?us-ascii?Q?bk4ao2gCLuH/cMO6riJVvOEAFhCnVOxqNhdmg4LUYyk1D2oxwTMSk4E2omzf?=
 =?us-ascii?Q?gmv9N5XFaWWjkMxc+10YDLi52FS3BxYhlq98jkxcjYIFaWz9xcuuBvis6mUn?=
 =?us-ascii?Q?Wtt+CR32CxGeel0l2xth/5XwaoYI0hN2YZEsh2cyHJRgkplFnNoBAOr5iVGY?=
 =?us-ascii?Q?4zo+SCKLlZVYQXmrvr4YHH6d7lcOFaqW5CS2rUrz7grsdtyIfrxVbOcWQm+I?=
 =?us-ascii?Q?hMahicTXKh6KXJCdIunZB/y6olqEbHiaXOFdO46631uO8665L0Zfeo8qjMrA?=
 =?us-ascii?Q?EhhRCBtfbjRKcCzRTxMVLqEr02+7qAXzKVHdaEJBsC30ELNZMMzI+6O5peWS?=
 =?us-ascii?Q?f3236fQeIq0qCYnIxq1k/mXCP1hkBfynHd+ntqHuDK0BSL4wX7oEOJBjBG/e?=
 =?us-ascii?Q?maSJDhs0n7liLQZwoC6FMxY10e2njovvvu5J4C9+F9xk2tyMK/6B4MxO9c2R?=
 =?us-ascii?Q?tGSi3Ze4vOEbpzPpUlikcQ+A+sB6Jkrmv6BKhwvH08eDxOk1KadjKD/X1NN0?=
 =?us-ascii?Q?VQ2F+fw2QMCRLvNIKmVjw6lqT+jljyjF9gQpA6kRnO6MUGGrUUAinkn5RHcy?=
 =?us-ascii?Q?/qDID40CdkaQWM0f2liiiPlqk7kk5zCFxSkhkI9yKNx18b/7d5gA1ZkzC8oG?=
 =?us-ascii?Q?SOgiyw+T1LVATNwFF34Q6r+Mc3v+Bnim15PZTnRK4XdAjaZy3VsWCK3HOqmb?=
 =?us-ascii?Q?f1y+Tpgvf2hcMt6gbIGqG53F+AgIzNrjwPPvowxWnBVlHPFL4eLN8FZL4Mur?=
 =?us-ascii?Q?Oi3PkIqWxIBnJ2fIHyo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf7773b-a827-4e10-236c-08db3527394f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 16:11:18.4448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zor/pmbTITKdGoZKe7C8gqLhlWNH5p5NyaigMo4huwShz1rqA4OjGY6ec4Fe5wvX0f6i8FiaeNJz5QnkqRJxWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5479
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v10 8/8] virtio-net: Describe RSS
 using rss rq id



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Tuesday, April 4, 2023 4:15 AM

> > In this field and other fields, we just refer to the receive virtqueues=
 as
> rss_rq_id parent structure itself is describing what it is.
> > Hence, we omit re-iterating rss_rq_id at multiple places.
>=20
> Personally, I'd prefer to spell it out, as it is a specific way to refer =
to a
> virtqueue.
That specific way is already covered without making it more verbose. So I w=
ill keep it as is, unless you have strong objection to it.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

