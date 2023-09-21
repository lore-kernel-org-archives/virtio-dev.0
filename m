Return-Path: <virtio-dev-return-13911-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A29ECD4958
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 06:31:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CF16C7A08C
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 06:31:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A308D986688
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 06:31:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8C0D198667C; Thu, 21 Sep 2023 06:31:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7BC2C98667D
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 06:31:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHdn/pICjHxNa6hQTb4ZxXni/TTM1DDXbALbDq/ZEqSREfRRbXuGEhJwKZw/DgyIpAt1OP6VJlGEG/Y36CsD65KebhpHUpHrlYEr/unXFoitT/Igm08qoNp1JpTCogmBSt1SRNEn8ClkhH66aUdAQaHFBIxWXK1Ef96Mrdl3S9QtbfU70n1N3ImVyzUPun22Ltm718JbCC5qD9rujVp2ijef1AKM2UXp5kIjQZKvjv/GxucNLduRNbqPSlpLqEO/8O1Sx74E7g7h2rdF+h/TeFdcb1a5mvUIe3w57tgRC+TTMCIn1A/RI3S/25XGl+nw6sc0o/c5rbfEDVlLYrGE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOj459Y3NW6AtIFdfkjNurhL5OvdV7JkiSqoXflOvRQ=;
 b=YP1vyYTZqlE6DH8kp9Cpq4l9oWsf+zJxR66pxuDvc8QBeRkq3L3KRqmJs02On9LQK1rg/lorQ4S2P8yO7i5f0ooiet/JxWLeJASGzt0j3ahPFuy7v2hFyY6Te04IPnxWnqT+Q7c55LPI37cu6u9v/6y3JJlmhld4HtcgAmC8E5u1ggGyBTLYUoS8U/7kj62fPqdv9Wql12PjUWjJnvpDWtE05HwGTCIQp+GYKVF5Ew2d1gVVL4oO7H+frz2gyJy6jBXXjH1fp1HES6BoHiJy740cRccVp2PhbM6AGcyKUU+OB1CsVnaroYrderg1G1PgYxGWPjSj6BzRTTxJuOED5w==
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
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAAM9QCAAAwSAIAAChWAgAAB0VCAABiEAIAAJySAgAA6DQCAAH/8EIAAIYaAgAAAnQCAAAZZAIAAAKfw
Date: Thu, 21 Sep 2023 06:31:01 +0000
Message-ID:
 <PH0PR12MB5481821D526E376771E70204DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org>
 <20230920084058-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548110E53C924C984FA24A49DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230920101402-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816F8341A77E63831316DBDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230920160218-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814A89793CF796412D6A27DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921004957-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E096E0298F29C9EA73B4DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921015810-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230921015810-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB7642:EE_
x-ms-office365-filtering-correlation-id: 98e5f284-dd9d-4677-54f0-08dbba6c5312
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 572tzmrYXndCcxiAlDKG+C9Yx0N22MQVSBFgTVVM5T3vleu99KlURaBIqq8aGoBwI7gjlRd8mc/VM7ZLw8bWYRvQzau7NcP+P+fX0e1TWzMcETMHc0nwjsyJmi2UKM02j9rMsrgtJ4Q63jk8adY4NZt3r5FCzvWe8IqcjYSIPDv19WMAyevsOF2uvpX2zIfeIr8CC+Z/QeqiqPX1fljHZOd7Sug3OrngR1wkfTTrA3WWeptTOFuGKIHJa1C+Y1V8c5sJt/rgPE4aKbsb+FIc+dCXK+i85x4zUIZJd965B+mwLuBgNv0Hig7UTEHCLAlK3QfDeftI7CoaCC/4gv5TrvHGD7NcoRmn+ywE3mx3SJhceAsFK8RAIg4B90pQh6USKbnv3cA/TQpg+SZ8QpYE9UPs4QaSzCxiHqxIHHYSZUYsvIJWWcGN7Mpr5lXKS56EEXQ3dOFbmTblTx2TT3VNd7q7K2Khr/Onb7e0G97BmEHm3BbHBnm13RoUQ4F7dQjq4acpD/aPjZTPTLdsYrrK8qMtW0ddt44719EQtCwutedvASOQE+Oe3uIMuFHmD+zVo61ZItJXejMvTLlR0vehbAss47ciBc2pGbiczZYDHoNNPXEwRUWFkoFVDfcBxNu/SySHLgyW4mmtTZpXpqAADuAgDDLGs0ANGu4FZdH1lMQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(39860400002)(136003)(186009)(451199024)(1800799009)(41300700001)(8936002)(7696005)(6506007)(478600001)(71200400001)(38070700005)(54906003)(122000001)(8676002)(38100700002)(52536014)(86362001)(26005)(15650500001)(76116006)(5660300002)(6916009)(66476007)(66556008)(83380400001)(64756008)(66446008)(66946007)(316002)(66899024)(9686003)(55016003)(55236004)(4326008)(966005)(33656002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?spfYRDmsn4DDb1k4Os5ey1BEE6MsWOiWNoAZHT2u2ZeMpN52+vnj3KwH1qyS?=
 =?us-ascii?Q?QHfgnbWzHGEJwXaizaZXlKEauAYl2SiXrIkWDdULh32UYncz/BjqlHd526aU?=
 =?us-ascii?Q?HHTHmOgRHm0inZN2zABeDodjFm1X4UGje2A8P/sllt1AsXqBx2f8HSLBX5hP?=
 =?us-ascii?Q?tBIDKI4RQxEeh+QPc3s3dcU9HMNpNaOtViUEm3KLPrzOfynRqX7qY50+pwdv?=
 =?us-ascii?Q?RO6O/puOt1aeUjNjUn3qK5f86sPsorvd9CzjkryBfbu2oNZjhhhGn/9x5Q5s?=
 =?us-ascii?Q?4ZSmnZEGAnLmf7KQ4Jg6bi8TpiYpaU1OzhW9tM2KVesNUc896hsawKSc+K7w?=
 =?us-ascii?Q?zjpnGME12ZIrRjBPLEmlSDUj8m8HNjskCipNuWszGFo7v1JRM0wGpeCly8HF?=
 =?us-ascii?Q?0eCDC698jZefhY6f10Q5JnWeHZh5SSq9TFsd912M1DPRbf5pjgOE/IDzuEqb?=
 =?us-ascii?Q?d5VZakzB5OEhZo5TYNJpvNZuOrLzHfi6jDbmeKEcPL2H4jg+8twd+K3nTLfW?=
 =?us-ascii?Q?ootq6JdmrLZ3TAasSUTuimEuUqY3HZNEcT6x9nkzFYFn8k8Xr9Gde1Cd3QyV?=
 =?us-ascii?Q?lAaogGqjSNaaDQoLUFNMgeMljY/Vn6aDCMmeGhAPQLjcfhfaG2JaTI+WBcrF?=
 =?us-ascii?Q?M1KArFmMKKlmHqFvSmZQl8TkhH2NKGvNbmeDGXd9EFA4bRbw5Cq0Wy8mIG+h?=
 =?us-ascii?Q?FHzyJ3f5R4sGexCWJChJM2Cjr4oHsvxlk1M4id2JrtqDcZw8Xf/sZ/lOZvGR?=
 =?us-ascii?Q?Lppipzm0EEpmUsz83x+DF1QGfITIbFloOcN0DEQbLWJSjClDTbIBXfMtdY+8?=
 =?us-ascii?Q?m9AjKz1UL5PmQO792HEArPdy/hag5WjNSrCivyfppZFxB64dWMq4siUdtqJd?=
 =?us-ascii?Q?kF59S1Ty3pTwUadSvlGDj+GxIJZGIhzj8+MKPrZc9oUyhN2fbxHdarvKeZnL?=
 =?us-ascii?Q?c3cRAy0SFBYtMRxKV4cmkkZ5WYz4Bxq/B4gL+7oJvX4aTVKRcDXYEKm4K23H?=
 =?us-ascii?Q?3jpBQNTSwrTXDdqrnGnbMnV54VBOzOEBgQ1/Or2KoAxE2C7E5e6t2q4maj51?=
 =?us-ascii?Q?wbwlGkUGIZkco5CLPhgxhpNz7hpYIFuGl3iNYEwrNShuGv3Wy7vJQ7eUCEIN?=
 =?us-ascii?Q?IBrvaaSATqbtvPmx+T5kVXVeDSen1yJPgcInr6HzRbWuMlEeASASm43ayHKg?=
 =?us-ascii?Q?EiRJSrG1NLo68R9sJ1fyckzGcP3nHctWSjHn3tKpQDJtm0IciFRkk97PefuU?=
 =?us-ascii?Q?U1zSyT10tFA1seIh9W8Sh4EmPlUcxSICc7E3brdulHnM3zEWWIvzxOiV9W8Z?=
 =?us-ascii?Q?Y/B/gEFI7Z1rEPTFfU3LaUzCtl2iRGanspZn1GKCN2ZMUXGXEptqWta4/2BJ?=
 =?us-ascii?Q?DFJOCZ2VoGdMg+h0wli/Pf1HS/2/EkB4qbTCQffR3k0MFE07PVcBFsqkJEYR?=
 =?us-ascii?Q?wmEtvMI45ugc8gGYpL60HC/PCMWtQCbkiVwoCfU5T5iSjr4k4Jp/4AYF2uSb?=
 =?us-ascii?Q?9JwSACVzOfDvsI4c3jDpynsiTNUVf7Y2Ey3H4iaqtVK+9GTEYWdnaQTAFyQx?=
 =?us-ascii?Q?GRLMWOWtp7A23RunX3k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e5f284-dd9d-4677-54f0-08dbba6c5312
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 06:31:01.5789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: meTof6G6Zr8tIRJwnI2ggvFt2QGn7Yz2Uc9Ja09ZGATLOaSv6kIlcNouB0mToVVlsw8bvuyj1FwacHtsduxi1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, September 21, 2023 11:37 AM

> > We should be enhancing the device context so that more and more items c=
an
> be annotated.
> > I started with small to get the design and idea through and will expand=
 the
> device context so that cross vendors can migrate.
>=20
> As I said, doable without mediation but already done with.
>
It is not done in the virtio spec that can work without mediation right?
=20
>=20
> > > 1. For mediation something that works within existing mediation
> > > framework - e.g. reusing as he does feature bits - will require less
> > > support than a completely separate facility.
> > > I think Zhu Lingshan also believes that since there will be less
> > > code -> less security issues.
> > >
> > With approach of [1], there is less code in the core device migration f=
low
> because none of those fields etc are parsed/read/written by the driver
> software.
>=20
> What is or is not executed in a specific flow is a separate question.
> But the point is vdpa and any mediation have to talk virtio things such a=
s feature
> bits. So reusing e.g. feature bits needs less code than operating the adm=
in
> command machinery to check what is supported. Yes, you can operate this
> machinery during setup and not during migration itself. It's still less c=
ode to
> maintain.
>
I wouldn't go down the path of code comparison.
But if you want to: we can take a concrete example of what is done by simil=
ar device who uses admin command approach.
The admin command-based approach migration driver is likely 10x smaller tha=
n the actual driver driving the feature bits and rest of the config.
If one needs more precise numbers of number of lines of code, I can derive =
it.

As features and functionality grows, every line of code gets added there in=
 mediation too.
I agree such mediation has value and use case, as we know it is not the onl=
y approach fitting all use cases.

>=20
> > > 2. With or without mediation, the mapping of commands to VFs is
> > > simpler, allowing more control - for example, let's say you want to
> > > reset a VF - you do not need to flush the queue of existing
> > > commands, which might potentially take a long time because some
> > > other VFs are very busy - you just reset the VF which any unmap flow =
will
> already do.
> > >
> > If I understand you right, to reset a VF, no need to flush the queues w=
ithout
> mediation too.
> > Just do VF FLR or do device reset, both will be fine.
>=20
> Not to reset the VF - that's a narrow definition. To put it back in its o=
riginal state
> unrelated to any VMs.  Nope, FLR is not enough - there could be commands =
in
> queue addressing the VF. If they take effect after FLR VF state changed a=
nd it
> can't be cleanly assigned to a new VM.
>=20
If you mean the SR-PCIM command, than it is virtio spec to define them.
We ratified this recently in the PCI-SIG of what gets cleared on VF FLR and=
 what stays that SR-PCIM interface to do.

So if other commands are in pipe, only after they are done, such VF will be=
 assigned to new VM.

This aspect is also covered in the proposal [2] in the DISCARD command and =
stop dirty page tracking (aka stop write reporting).

[1] https://lore.kernel.org/virtio-comment/20230909142911.524407-7-parav@nv=
idia.com/T/#mf15b68617f772770c6bf79f70e8ddc6fea834cfa

To me, frankly, both methods are addressing two slightly different requirem=
ent due to which it may not be worth the comparison.
It is not either or.
And so far, technically what I understand is, both methods has its pros, co=
ns and limitations due to which both requirements (passthrough and nest) ca=
nnot be addressed uniformly.
Both has its space for the solution it offers.

At best, two methods can find some common ground of commands or plumbing to=
 reuse, it will be great.
If I am understanding is wrong, I would like to learn and discuss.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

