Return-Path: <virtio-dev-return-13908-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9671ECD4959
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 05:54:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E0F6B2AD57
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 05:54:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BAA2F98668A
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 05:54:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9B424983EB5; Thu, 21 Sep 2023 05:54:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8B13298667C
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 05:54:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gw0e+aLzft28Gazqf+CDldvwzg8WjEyGAY5Glv0j3+Gosf7PqVGDrEZZ2GDk3SEfJ9h5mu8NQD9WXMLy55pqpw0gAOQiUhuqc8K4arjwcYUNPl9wbr9OoUvdmT6tqEJOxyUivnU3Y/XTXIZcT7PcMxsFoU7kEI1AVB0Aros42E3H4Fn/vCFgAkUADIcg1rGxjqQ/DHNoBkaffVlxA6XVdtOut2PSB4IU5FCSRtGhZ0pbCUmg011Tr06soPWtMf8bdTmt8gpIoKKA6SxyQaKT9X26nqjgcJGM8Sjhp0IEplFVdcXVFR8cjRpG1LOBiyiv0qxncKGRMew2NBQfG/P1fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jw0uCFRr6rji9GzPEbZSGKiJtqbWAHs1+LTapps8k/Q=;
 b=P7tzbF8LrLKmn6l8d8xCbgNDbpqd5aOuD9npSvxEDvQVnEti5eXpuUhigjlar5XY8Paz7U6x2vmI8DwgJav9r0vfXS9z+aJMQarsEje4YQDdLjneKuobT+Jb1GXgniTTVjOV8msi1tAhVESEZbNPoGJ989YftWw1GmT1HDx1GVZVK7Jn7JEIlQsHwo3nk0+ewVPwdmqnXQyN+dawUfoymHPBpVu2vtVYFVsfFlMyjEfCYPFr4CITfX81S53ONQtIsqIGf1TGy38YgM+g3tqdhNLDaAEK4lUlI4n966E64AIx8wVrHfby6h3r159DTAJ2tl8aCxMhnjw0bpZhkGWm4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason
 Wang <jasowang@redhat.com>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAAM9QCAAAwSAIAAChWAgAAB0VCAABiEAIAAJySAgAA6DQCAAH/8EIAAIYaAgAAAnQA=
Date: Thu, 21 Sep 2023 05:54:37 +0000
Message-ID:
 <PH0PR12MB5481E096E0298F29C9EA73B4DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org>
 <20230920084058-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548110E53C924C984FA24A49DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230920101402-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816F8341A77E63831316DBDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230920160218-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814A89793CF796412D6A27DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921004957-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230921004957-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB9221:EE_
x-ms-office365-filtering-correlation-id: bf84045f-91eb-4e27-12ba-08dbba673d3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 s1RbjkYKlMR90F4U1h365/7UYyHGuZXVdxtLfNmK1Gz3EJ5WF73e3NO0e6xlbrUJqD+b/z8xFb1M6zy9dfszpW2V2pNltd+JrGLpYzh+uswQ3NM1E01V4ykabDtTcWcub83pley3LmH0nuDTBEh6B4sfi1Q9D6b5msBOXzbDJ1s8G5WmzQ/qAlcDJI3iYCapsUywRBSjDqYSqnQo8oPuWtRSr9fToBvCJPnZ/Za2/FL0/noVR37qpxMfV6J1W2W1yLYKLj4GG01bn2krnJfIsrFLM7ugSQZbe10ZaMuqnOwvHd/Y3khXEeGp+mzLxyCak/fN1IlBRWXkdTtVRycusDgvqud1r/cEpOVslXgEohhgLZ6GpLzLW9FwXWNunO/Bi4EaM0LwAaxSIX8F5J6pjy6iIKQ1qWtEyK/UV6jN3RPAFKOpTmGDoKcqFa9n3AXKUFQQFQXozGf/B8B4QSAsIz9iJfnUzOnNvYvEc2FrhdAy8KjF1o42JZM8/sRBc4V+tysS9jbobvm+nn9w/XLLjiBk72AmEwWjlCJOchZFt4JB8rRhkg6Dv/7v8jtt52f1re+dYzJbWyUI2mfwOCEXMb1ddqt+1dnxrQJ7JLKxSPs8C8KWUmYfKJlBNpdbbupu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(1800799009)(186009)(451199024)(9686003)(71200400001)(7696005)(26005)(6506007)(38070700005)(5660300002)(55236004)(83380400001)(122000001)(38100700002)(86362001)(33656002)(55016003)(8676002)(4326008)(2906002)(41300700001)(8936002)(76116006)(66476007)(66946007)(64756008)(66556008)(54906003)(316002)(6916009)(15650500001)(52536014)(478600001)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6y2sEpE+WOj3vwi/msM4zT6tHikob3kwJ3e+BqJvzrkJbpixmnrTnVujovKx?=
 =?us-ascii?Q?re+hy0l+PKCBFcMZt/bzFmmOLCcoMCBlQikYf44ZTv8qU2qpaC58sY5abXzF?=
 =?us-ascii?Q?9dUhq6PUetuqte/ldQEhnmcCJyIq1seAeq1aF4hDZ8AOg2zaLR6qMDJupBFQ?=
 =?us-ascii?Q?7i6XZIcbDyTewsDTYyd4lsM9VnCRMCP7v1ziBt53rgWHWq5MWPrCT1IxgKDi?=
 =?us-ascii?Q?l44GG9Qg4H1S92jai6Uc1okBkkgkbt0f0VNXXMQpZiRvT/yNW1/5DEypamh9?=
 =?us-ascii?Q?6g5Gtri431qyYBOGFzSzOK5QMRRJftXuMw0UQFHRqXSDLOsRXoG3fVOhA2c/?=
 =?us-ascii?Q?bUaceC+tG0/HTul1Cr5xe8wgC5aoaJiHNFRQp3Ke3kHjR3fG9TKKrQrR2yZ/?=
 =?us-ascii?Q?jKMUOpSAhX7AfmhG7r9AU8QhCRi9GDRU9QF+KAUtbcEFTmGhChQIrKSV07a2?=
 =?us-ascii?Q?CH+gFcpKPV+M553HK5Wjc5975vYzIKaiAsx25DtxJnwmKGCMukZHN9EX/ide?=
 =?us-ascii?Q?rrNpOQLEcHshDTxaTLBHsyZD2VpKkdrfQQE5TRSB3+ozv51i5mk7n3vsuN/J?=
 =?us-ascii?Q?vWYmmvD/yLA1cTG38bFNhLYZAZaE7zUpSoAQiLfEXmQjvDM9w3j+zeWUbbvC?=
 =?us-ascii?Q?DU2JB+H9bnydG2CBNq++hY6NKuDK/VVX5ltdejCiLk+N/q38zjjLDWCbLMrP?=
 =?us-ascii?Q?ve1nu3kvGtDxyh+HfY1hXID8Qi7kw3PDjvXKJbBatWNj0cgNgUuzHBb5Dizl?=
 =?us-ascii?Q?WzSdE86Lg8Z3jZLuSZdjRkWlNiGClG90OMrJnVghwhz4V6pnWgoHiHGt/+3L?=
 =?us-ascii?Q?u9UtrQ5MxQWWuCi1KfsISTR/XV3qfEZzl/KMYe7eoSjgUNMiQG65B1G7PiLB?=
 =?us-ascii?Q?ESEuIkLhwueTdYg9GUdwAM3f5SxG0C1GiYv1Pd9WF1ekkz1ef03biyx45cJq?=
 =?us-ascii?Q?3abq/fXSHReazuG2hRw83erT9rIi94jXZ9K5pyCDsiIh3WdMhNpmptE/hHWC?=
 =?us-ascii?Q?aSENWE0j95U3o2GFUuSqz3LP9rcZDV5TGTPAeZDN0qaWf3Jq3M0pdPLl8LG5?=
 =?us-ascii?Q?0k2MZqqqSgI3AwlYpMSd4OkOK0yYrn+Q+uhOyoiJxt8D08vMYHpOEzs9PlGV?=
 =?us-ascii?Q?OnPHzqMBB0413/lkabuOjBoqn6vjw7PuxlDaGA6bun5qvDR5Swz+qMtlym9r?=
 =?us-ascii?Q?qq78LVQiJmWW0AGZreEjKRWX+bPbIDPJ33h25unwCZGBIFGYjVPUR+PzlBpB?=
 =?us-ascii?Q?aNsgNAL4jNyzBihBqW15TjPf3X/OgqddYKDcCOW42g5hJ37fo873+b+TNv6m?=
 =?us-ascii?Q?KS2VM9gsqPcjbAsf85V7ymCD6Z55U8qMgxqWjJBxKI8Tiyryd66RY1pnNzsy?=
 =?us-ascii?Q?ojoSgIc6Dg5hvs5+rVlVccJ6jW1qvojYPRUJryID2LErEGNw9KaRxjM/R7Lx?=
 =?us-ascii?Q?cIQNvg4LtwGLme00KIdEpaxTx8WotDlE0kkpp9igodULkD+2jqMcYlLNbPAd?=
 =?us-ascii?Q?mmjALOSjjsmzu4IuZFD8SFallzCstt5hTCrLQAKPiRAgfiBicWLtWo22vabS?=
 =?us-ascii?Q?aEu9i7QAl1u63s86blc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf84045f-91eb-4e27-12ba-08dbba673d3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 05:54:37.4481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HKP3yOEjEvk/yy3dOmuO1Vn/ox2++qE0C5FGXx9gpRxpbd6ZzVUDiBzu8gDbNWmoV3E+XykO0+jDpkOCVaPszw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

Hi Michael,

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, September 21, 2023 11:12 AM

> I was attempting to have each of you see other's point of view.
> It seems clear I was right, at least one way communication was not gettin=
g
> through. Let me try to help.
>=20
>=20
> First, clearly Zhu Lingshan cares about the mediation use-case, not the u=
n-
> mediated one.  Mediation is clearly heavier but also more powerful in man=
y
> use-cases - is that obvious or do I need to list the reasons?

I agree to it.

> To mention one example, it supports cross-vendor migration. Which the
> unmediated variant maybe can in theory support too, and when it does mayb=
e
> in a better and more structured way - but that will require standartizati=
on effort
> that didn't happen yet. With mediation it was already demonstrated more t=
han
> once.
>
We should be enhancing the device context so that more and more items can b=
e annotated.
I started with small to get the design and idea through and will expand the=
 device context so that cross vendors can migrate.

> 1. For mediation something that works within existing mediation framework=
 -
> e.g. reusing as he does feature bits - will require less support than a c=
ompletely
> separate facility.
> I think Zhu Lingshan also believes that since there will be less code -> =
less
> security issues.
>
With approach of [1], there is less code in the core device migration flow =
because none of those fields etc are parsed/read/written by the driver soft=
ware.
=20
> 2. With or without mediation, the mapping of commands to VFs is simpler,
> allowing more control - for example, let's say you want to reset a VF - y=
ou do not
> need to flush the queue of existing commands, which might potentially tak=
e a
> long time because some other VFs are very busy - you just reset the VF wh=
ich
> any unmap flow will already do.
>=20
If I understand you right, to reset a VF, no need to flush the queues witho=
ut mediation too.
Just do VF FLR or do device reset, both will be fine.

>=20
>=20
> But Zhu Lingshan, all this will be pointless if you also do not try to do=
 this and list
> what are reasonable points that Parav made. Please do not mistake what I'=
m
> doing here for taking sides I just want the communication to start workin=
g. And
> that means everyone tries to take all use-cases into account even if work=
ing for
> a vendor that does not care about this use-case. Otherwise we will just k=
eep
> getting into these flamewars.

Right. I like to take this opportunity to ask again, lets sit together and =
see if we can utilize common framework between two methods.
For example,
1. device context for mediation and without mediation can provide common st=
ructures that both solutions can use
2. device provisioning (not in any of our series, that can find common ways=
)

May be more can be merged once we are open to collaborate.
If we face technical issues in unifying the methods, it will be self-explai=
ned why both methods to exist or create something different for two differe=
nt use cases.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

