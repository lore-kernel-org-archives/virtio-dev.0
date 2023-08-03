Return-Path: <virtio-dev-return-13436-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA22C0015E
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 09:45:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3E23E2AC4C
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 09:45:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 373829866DB
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 09:45:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 27B7F9866AE; Thu,  3 Aug 2023 09:45:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 170F89866B1;
	Thu,  3 Aug 2023 09:45:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQLd6BaRtzrAkfgptruUWIJcF4kzF0nohpYdAXJydAiZEaNHieW8jMaqD0b+ovrUgkAgGIQb4wqD5UgWieiQD6HWp3AtEDemus0Ts1iwREF5KlBVKtnU8ubbTzSiE3kdOfKC6Y4fgBphYPOlp+KwsJk8zEauzjnAFxv35j99iRu1BrzAhgKee2DFoo88XECrwAGckWB3ss17ZWXgcpXCO3WHH4r0e+zwObOGQl+3ckDn1uqK7j9EJvfsvze+yYONhVLYjtMTJnOl3DNKpOClDSoK7hTPP3bI5VatUgR30MfUtvcZzrazR+cqhK3dwV92r8YEgjZKqrMXALdUSUzHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kDPHZ0ZS1r1qJ7gcAGjBnkBAKC0edEuVs3gEijBnC8=;
 b=JwHaq3SrCA26rrMM315EpWh8wupLSMJomwAUvKVBnmezIWF+F51RpJC2loID9iTd+xlVwq9HGExRLogF8uGsNLefqhX5s32kwi5pklhhReYslYpy+tdTEG5TKqsVQDvMRS1J2bq5+EoECGVYTATsdmwaZXwimW7+3Tk4Gedw6pF8KZxeLqFqIAvQoDF5d0PTZZ/ihwdGiRzHeWa+/awy1oyvk9phiyKyxe5GH9u+Ith1W/RWSjB8fW6V3x4xWgJ95hPVca3Knqh82kFQlmwGKXeVm45kQH26MkwAIojfe6qwC51yOYWz52Tq2C39zWk1x5RHm/yqSRxb+x2/pkaMvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Thread-Topic: [RFC] virtio-net: support access and control the member devices
Thread-Index: AQHZxeT2Q5D2+syVdECqHrje6hzlHq/YUmCAgAAASVA=
Date: Thu, 3 Aug 2023 09:45:47 +0000
Message-ID:
 <PH0PR12MB54817EE3DEF6F5DA31648466DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <20230803054333-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230803054333-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB9454:EE_
x-ms-office365-filtering-correlation-id: 00d5ce3c-2aee-4f86-2db5-08db940669ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bY8T0DHtrfCXBnKyR3gOxFE1fDM57cg6QorMspIQY1vHo6AiV/o4jvZSLCYE38CANWzfNu6tvIoP2JCZnQEGB+glMZNhZ3BXFYszoVlo4BJNezNr11C0ikBR+euDleIKEEpXxCN+fHb1TdQnqgyUNX3Ou/59rheOwHTuso57VSYl3teA0xM53kRC4OzCqV3PgYd5JR66D2UD5RxgSAnSae6usWqfsWACWb3/W9s4b67Jj2vTeXJFwo4ne35HgAMxUDdpJniCQYmi79PpcXwGrY8tkQEXLDVObqcJJ1ewsoLXyEm5+qIOM7flbuLP3DDsxe+yxXDzDGP+YSET7N33sPsJ3B5tQ6+5mpPrjmDqqsQTmsxuK475Yr4GPX7JAs7iJ1c7EocC3+dRH86oH2QUjGKo2nCuGdZg3VJyoBXksrahRXO6Eb/PTSH4Ipl/WQGbDia2jLS2txmTwg/qAGVP3hRl6YDokcl30SnvI3nYTkxG5iFCyNp7StJJv2sCIBbedsDQ34zl9BSgtbau9FIlP0ed3oTMgZbRiQfL+GLN/1Iuwocgz+TrkUVy3yInvTr6vagOcf1AoHK6GeKN1S46/PVsnaG2qv5ISSGOCUcPUMgYElpQ6a7pIxIGLRMcO4MK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(83380400001)(6506007)(26005)(186003)(41300700001)(4744005)(52536014)(2906002)(66946007)(76116006)(4326008)(64756008)(66446008)(66476007)(66556008)(5660300002)(316002)(8676002)(8936002)(7696005)(71200400001)(9686003)(478600001)(54906003)(110136005)(55016003)(38100700002)(122000001)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8QkJMhs6m2nASCzoLrxins+i33iwqrJuBbE5yVv0key/6z40CtZQIfVISyBO?=
 =?us-ascii?Q?On6nYaGeYam0P3XDDq6FLgm5LZlRaN61ZfSUW+TEJjVnJt/SKbXgE6t2ja9c?=
 =?us-ascii?Q?dxldzXjInQlsgnj5fXrvrS661rvT1n+adu9hhVq5HbkPXsCxtx4iAGEIAMY1?=
 =?us-ascii?Q?fcTfFo/hQOGns/NfB3kd+z4EjpW5ahRGuw741/V1U+FPm0clKBPfdy+0B+mU?=
 =?us-ascii?Q?XCFQZ8XPP6bfrwVvmQEOmIA2PiFHtrNQX9KQhj9cHkjVhwsTbD0hQoBmpd4s?=
 =?us-ascii?Q?gwUzJy+kxK3WZJgkzkT7uOyUL5FL1oez2XkgLeh1v90AJQA/x8sVe/Y7LyvU?=
 =?us-ascii?Q?8vdwwHHdUbuV2CXdl1omhp0qnExQQNYzBvgWo+23dFSdOIdOfnjlAHORnfWc?=
 =?us-ascii?Q?qZjXywdHhIgICk34pwOJNN1bQemUkjncX/3AcTOYDUpVFiXsNfqurGZ8UPSF?=
 =?us-ascii?Q?JHke+R7FIyIB4+vh2N5aIfrHA6+cLRIErCVVO2hyIBp7TdLlGfds0ByKoD2f?=
 =?us-ascii?Q?pZtqxLqinNekEetqe2Utsm62tLLq6XzN6P8d2S2ZRr7yVo+ukGDz7l6QB69a?=
 =?us-ascii?Q?cvaWCyfAkYqsUHP011kdkR/1zgfdJg6uLtDcmhayeTNceD/XD2sVmk+bQ37S?=
 =?us-ascii?Q?WnGTEObx7wJGIS5u/dSPlTFX8Qlq8wQmwfRalb4U8/mGLiha9eMcccFA86K1?=
 =?us-ascii?Q?ZMqqIuzXf/ZVVyiSaFEBCcQAXjfbieE0PHtffRMObVB6Zr64SXZhO65mxc+K?=
 =?us-ascii?Q?m0oklyYqgrYzLqawUUhSy3TDVvyiQLGqLXljllTHup50WNQtcrFVvqFXE1ti?=
 =?us-ascii?Q?RTdKa5zEyFvhSB2lEjtwoPy80Ue6T6xbas8SHcjGqBE7zyGNxNMZ3TY/mBoA?=
 =?us-ascii?Q?+HFFH8H8KQdwDRfXbXBIoKLzsmXV5eLsreF6F3C2nDmLJ0fL8yJcpISLJWjK?=
 =?us-ascii?Q?amLUsUUQSlqP7G6RKccYsh/iBaL11NOUGLMglq2zcr6Aa4mY+5nIuxvp2lWs?=
 =?us-ascii?Q?eQbfVwZNkB3mpbQhd8SexFFzUSfyn6unYtBP4sp2RR2ZMh/qnBiDdlXUTO4L?=
 =?us-ascii?Q?CyvcVSsgSiWVzoSs2p6mqrCBRU0Lbu763leNiSGHPB8DfFKRyrgXpPVa3Com?=
 =?us-ascii?Q?6K/Rya92bZbLSLqCEuGxTzNVBjDNf52MBqG0Ni0jpy7AMCHhVtzQtYsJx2io?=
 =?us-ascii?Q?tp7vzzBYbiqvCZZMYmy09R92etmmTtlTdUaALqOatZtDKa31iwLtHOjQ6vj5?=
 =?us-ascii?Q?IfW+fHmfp9DzdxKTyi5oREDy4le7rlitg89Jv2InsALUGXfbzvBt65A8BHfg?=
 =?us-ascii?Q?dILzDi2wRWekScxQa2mw0nXeO8pgXU0Zk5BjTLWO2W95btuqzVDwgZu2OLNm?=
 =?us-ascii?Q?rq+TOlpoqgV9Ctqa470isc8r4vlTxP2+VLmk64TDEjLHbNFU+G904Dd8BNzR?=
 =?us-ascii?Q?2u2pJW0F3ecxgsotpoVyX5hPCxXtDSCj2tDh9/nZ+LafU/OBBSKmiZhtjPgt?=
 =?us-ascii?Q?PaivTnshMYN3uLEjXS/kFOuV+d/PIBOykRLXsldui/8m7EDQbRbiM7YO3e/d?=
 =?us-ascii?Q?F4b07STdpoqyBi8WaNs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d5ce3c-2aee-4f86-2db5-08db940669ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 09:45:47.1932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /fbzN8cYRNd/M3d+cNNHpR5fmlWaP338gdrTbNePCawZj9gC+JTj5I39KBTe1I1BI/TeroFwvF6nXFGfuXpgKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454
Subject: [virtio-dev] RE: [RFC] virtio-net: support access and control the member devices


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, August 3, 2023 3:14 PM
>=20
> On Thu, Aug 03, 2023 at 04:31:50PM +0800, Xuan Zhuo wrote:
> > Now we have the concept of the device group. This allows us to support
> > sr-iov and siov more conveniently.
> >
> > The following description uses pf, vf as an example. The scene with sf
> > should be similar.
> >
> > According to my understanding, the management at the level of
> > virtqueue should be handled by admin queue. And the net related
> > management is still managed by cvq of pf. So this patch works with the =
cvq of
> the pf.
> >
> > The problem I am trying to solve is when there are multiple vf
> > virtio-net devices under one pf.
> > It is necessary for administrators to query the status and information
> > of each vf and configure mac.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>=20
>=20
> I think we should use admin queue for this, and not cvq.
>=20
+1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

