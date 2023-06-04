Return-Path: <virtio-dev-return-12857-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99393C7EE29
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 23:57:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 04DED2B04E
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 23:57:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EFB2C986423
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 23:57:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E1287986338; Sun,  4 Jun 2023 23:57:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CD4AF986332;
	Sun,  4 Jun 2023 23:57:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oej2VNLBcQcZ9RlVYzDLnxQe3lvm0GHsmlGaq8Kb9SedTZb+65JMTyJli5tyLcVuUqEBSoBhmPSNP9bs1I2rWLgmlE8OLs0EDmlvZpLl4lPZAoNN6HHLRnBGP95U8dRtxzVUcvu6riN/oSpUSOzLFdIp4Mivp03YpumK6FbLj5VGG93txAZAqiTWkTniimzWil7L1r/7ElqrRl0y4iB8Qwh1D24r5LmWpZamukzjtVAXPs+t4fN91kCFIGyySz2y9kZyOnyJ2NTDX2RbuYoBc6kufvUL326sdiQlY9egZa+KyjHVFB9glhR7HPAMsyD3etXg66bVGKDJOSHsQRl3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjIv2eIVDjyLaablpeTONJtBP/+bSPeWmvjj3xIJHdU=;
 b=QFiPHGUxVTS2oH6fs2gDu/9LzAMGGLWbQXkXprfDFYFjalxWlk29kBVl4X1uhzj064oFwagmq8rF3OZJSRY6ZCr/OniorkwD/CG5XO6rcdA3HaNZHkhvZB6ZCIcdvwOXXCptEsQA9cyEhHB+FwEnXjHwfT3Vih9jDyyYuCRyFtbIOl3uqDZ4XInb+iU4S7nBNAQcJBhmBoEgoSOuzbTM470XEpK24hBBQ17vE/rZLQch56lczhNCAo9EPjtSa8Ar48FKGaW2gHw9rGrp6B0/9iF1bCCfgsbUXEZ6v4utVq7PzOIPcJwM/nFyOF1j5iHaTL4cwokkTFiArz/ZvFBLyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v3 2/3] transport-pci: Introduce legacy registers access
 commands
Thread-Index:
 AQHZlZHrjhTPPTQ0ZUaNTBTq19TtJ696o/kAgAAGnPCAAAfAAIAAAPOAgAAG/ICAAAKAQIAAer0AgAAZ7jA=
Date: Sun, 4 Jun 2023 23:57:38 +0000
Message-ID:
 <PH0PR12MB54817B89F8A1BF10576DAE54DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230602203604.627661-1-parav@nvidia.com>
 <20230602203604.627661-3-parav@nvidia.com>
 <20230604091651-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481195B63FD61C35447FFDFDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604095615-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D7C7EEAC610BBBDEB69ADC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604103309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813E50A9821F960C43C5BFDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604174856-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230604174856-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB7672:EE_
x-ms-office365-filtering-correlation-id: 8a844b9b-08d3-460b-82df-08db655779f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tbQeu+zNhm5+jFX2hkcPuqZWrmqSQqMx9pqHpCUKARMYwU3gScmBjuYJCx4vyEpEWVNepPO/Bubc1OUF8Db/YSndrg9aJvOkwLcRAXv8hxyPsffdyDYGeOUjNL3lmwB9WK1sJM+CtbR4Mt69uiFQ3qc8Ak3gNDlqJo8vgodxDu4kS3u3UxlamAyCJ5pJLPhgr4QSQk//O6aNqbPb+0PzGWamqXlJoylAR0citt52VXvJdTxmlJcNVfe9UzPhebZOd0WpGBUYBKetoH9GZZYcdYY1G3nUyNb2PSHawhyzvw0O4Vgh1mEki9e8jBdPmaADH2mYCaTI5+h9uxzhXRniTr4y0FA3O6U5Nw/SoWW/hxxkhqPY5Y9yfwERGpteSwLDQW2sjgQuKvIznmoE0ekbUwpzLjkyr6XUDNN4M9R97iveBcGrU7F9ITNJmakoNgkQ+QQf8SDWj+8SqpbJD/1xiBk2jRHDx5drIhJW0NIiOmrh9VzzL6PRx+PMUOMFUPWbPULmimxcIYhg1cRaQjwiLaYrDRHapBroQQNfVPbV8u7jJaD7Z2sGIXBxG3wu3Jp4qt7qlJONgtkHys89+Nfr4Ntf2ANuENJPOE0WVqnXsqRK7zcKI70uF2TDeVYxVNKa
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199021)(8936002)(8676002)(107886003)(7696005)(478600001)(54906003)(55016003)(41300700001)(5660300002)(52536014)(316002)(186003)(76116006)(4326008)(71200400001)(64756008)(66446008)(66556008)(66946007)(66476007)(6916009)(9686003)(6506007)(83380400001)(2906002)(122000001)(38100700002)(38070700005)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YqAfySrlZxHN5wiCd23GG7eeJ0bhS+6qrh3AzevXMZKnTAUNd5SOP2PCstLr?=
 =?us-ascii?Q?ZO+z8CHSBXg07UtKm7+LHmIGe6cWvhp498xnKwmz6L3QMPDYMa2Wp76fAIhb?=
 =?us-ascii?Q?leKzNtfIl0F5K0h3EjGQgbljCQPE5gM3fZ/nSNx12IHXZZVpCN/i+V6WksYu?=
 =?us-ascii?Q?3tX1dmGAAIGOUG4VjjGxkebmyH4G35c3DK6D7nCoTtZBSrhZ+xlvbDoeOo3y?=
 =?us-ascii?Q?A5DlH4fyfE1jn2tA3XkzPzKftqcSREJ/0r/6KxF2jxaAfF5jFFyYMxXmsiBX?=
 =?us-ascii?Q?+uDvGi9O/kbV3ShoDa4irNlPw4+X7pgGtGgmzEKqcTPtUV2/U9FXNFarAwYC?=
 =?us-ascii?Q?mVnjSlU3lBm2gUbVFQx+LYgs+4HvviwA4hgCXBTsWyp8n4/vdzqagPwqdYCT?=
 =?us-ascii?Q?Qs/kjZhukF3ug3O/yMeIuthjxu6bkqzF6TXajKISoOFGG+3DaVeDr0YA1JS8?=
 =?us-ascii?Q?GI6nZePeaxxCq4dZJlrC4hFdTx+fEoiEIK7/q2jEQ7AvyJcKbaKrfo4eGsgJ?=
 =?us-ascii?Q?t1xH1VAr7smE3KdvkabE3Ja9qRW36WphryQdHscDJsdWXhCicfX7K1je8NLE?=
 =?us-ascii?Q?nJTdSKfWPNtx23Z9/gD18tFOnotHAgl6HT1bynIZnGFGFa11Jh9mWQ7ztcho?=
 =?us-ascii?Q?XZBG1UJD09Oapqd2S6VDsf+uutt/Dl8Te4g+ZbVtm41Mye/u59hx2evQqcGH?=
 =?us-ascii?Q?5ybSmdmm54UxKCZWlwukK2Ds9zOiSqA5RBoCrt2q6LuXoDshFGftOJbWWnRa?=
 =?us-ascii?Q?56VHcVh5t+Z4Rub/tYYK5jlt7YPYF6o8tFuxfjC0MuYBt1S76R8kJIIlUQKZ?=
 =?us-ascii?Q?rKxtiEAa3TpGubJbOI6y3hJqLmAtZUz57Cb5nbL2Qp3RjOoXrckYtbrkIH8/?=
 =?us-ascii?Q?GDBmWd48AGjUpLfGS+q0r4XAoZ9KhEkBFkm/OgCvSxsi5tw9yTT4GST6JXxx?=
 =?us-ascii?Q?CaOJSOSLYaaMK9hdQPnxsVwO2KqFFA3Evi7ZNtl2vH0JpKmyCW7mmbBX32S6?=
 =?us-ascii?Q?pjeLSLvLE469hAM5VBHgTILoB4MZaaKXTBhwpNpoNdgG1gll8Vw9BCgm+O86?=
 =?us-ascii?Q?xVNFyT0pll8jdZuPmZcSL5vicY4gkER/StC3u5kfejP2qJd+PjcZPXyOEalG?=
 =?us-ascii?Q?nCkpmUYQggMP1/SAi8aO+Ox73IeTmqPy0wss84gCvtAHJaqARcigsqfl36lz?=
 =?us-ascii?Q?5b+MfmZkcpqIq/eX1s4eNPKOXrKIkkVwhfD5aMxnXy2+lcerUiaqK4Mg3jfM?=
 =?us-ascii?Q?7abRKBqVTCXxTZYte5PjmBRchgSnQy+aHHKQvtwuKovDk++6eaFewlySw7cO?=
 =?us-ascii?Q?WLHHGM2j6NEeeV4XeXIp3MpOweQEpNWc0MwWQh7BdBhwuYGVXm4dEEeh6HcK?=
 =?us-ascii?Q?hMj65CxfcxD/gIfB3jsONF8an8m/EMkUWB4+Q0KPp1N1N0Z4jqPmMRyVVhaR?=
 =?us-ascii?Q?U+Rg3A1J/tV5MVCXIKcqSonpZHRaGbhl4jLG9eFv9g6fOo5usx4QE57kyhqH?=
 =?us-ascii?Q?8W9mxhXnq3j//2D2vR8C7vo86wfUbLFz4BLuyPjJnvL75kgmy8Lma59uIPer?=
 =?us-ascii?Q?+Ybd/Skren701wOyR2kSYLclI5/Z2yFxXMzJWpVoD8MPrVVTti2b2Dn6yj+q?=
 =?us-ascii?Q?K2TaOUZcA6LLtti4Xn9/skk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a844b9b-08d3-460b-82df-08db655779f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2023 23:57:38.5028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y4yeK7LbN1iXL51fYvj8/qrjDrDdzcgUPU/UPH/XDiVP1SDEGxXkIJjJ5hV2wQqC5R9gkN20vJO1EVTp8gdamg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672
Subject: [virtio-dev] RE: [PATCH v3 2/3] transport-pci: Introduce legacy registers access
 commands



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, June 4, 2023 6:10 PM

> > Conformance chapter doesn't have any links to aq requirements.
>=20
> Good point, but the section itself is not missing, just a couple of links=
 in the
> conformance chapter. Sounds like a trivial omission we can correct as an
> editorial fix.
>
Yes, to be done.
=20
> > > And it also somehow uses the extra command to get an address and
> > > then translates notifications to writes at that address? This kind
> > > of thing is what I called a theory of operation.
> > >
> >
> > > A couple of paragraphs.
> > >
> > Yes, but I don't see such details for the AQ, notification coalescing.
>=20
> I certainly tried for AQ.
>
There are many details about "access other device" design details located i=
n the commit log, which is not present in the AQ section.

=20
> For notification coalescing there's a whole paragraph:
> \subparagraph{Operation}\label{sec:Device Types / Network Device / Device
> Operation / Control Virtqueue / Notifications Coalescing / Operation}
>
The paragraph explains "what" part of the operation, not the design of how/=
when things should be done by the driver.=20
I am not against adding the theory of operation, but I clearly see being ni=
tpicked.

>=20
> > These commands are not special.
> > Commands described "what" they do. "When and how" is not described in
> the spec.
>=20
> If the "what" is "return offset for notifications" but there's no descrip=
tion on
> what these notifications are then the "what" is at best incomplete.
>=20

The command description says:
"This command returns the notify offset of the member VF for virtqueue driv=
er notifications"

What more to tell than this, as "driver notifications" is clearly described=
 in the section 2.9 for it.
May be I can make it little more verbose.

> > It is left to the driver to compose such things.
> > How Net device should use "queue reset" is not explained in theory of
> operation.
> > What is described is mechanics of queue reset steps...
> >
> > Those details were put in the commit log, and not in the spec.
> > If you want to add theory of operation like nvme spec, we need to have
> dedicated section.
> > I don't see a reason, why this should be the first patch set to do so i=
n v4.
> > I am more than happy to add, but it can be done in generic way as follo=
w up.
>=20
> I don't think so personally.
> As bigger issues get fixed, we start polishing up smaller ones.
> It is reasonable to ask that people try to decide on a high level design =
up front to
> avoid sending you back to the drawing board - though that's unavoidable
> sometimes, a straw can break camel's back, but that's not the case here.
>=20
> Nitpicking when the design itself is undergoing big changes is unproducti=
ve for
> everyone - reviewers and contributors.
> Now you are getting asked to clarify things is a good sign that the desig=
n is
> converging. The less time we keep arguing about protocol the faster this =
will
> happen.
>=20
Most or all questions about notify were literally answered in v2.
I missed to add them to the alternatives considered section in the commit l=
og.
I will add it.

> And I commented on previous versions too that the notification part is no=
t near
> ready, and suggested splitting it up to a follow up patch.
> This is still the case, and I still think you should get the 4 config acc=
ess
> commands merged first then focus on notifications.
>
After you asked about this in v1, I further clarified in v2.
I would like to cover the notification part as well. It is really the small=
 piece as it is not baking any special or new concept.

> > > But what is the answer?
> > >
> > BAR 0 should not be used at all by the VF device for anything including=
 MSI-X.
> > > > > And does this include this new command you are adding or not?
> > > > > It mentions bar too.  What about e.g. MSIX tables? Could there
> > > > > be other capabilities referring to a BAR?
> > > >
> > >
> > > ?
> > >
> > New command also should not report BAR 0.
> > > > > How does hypervisor know whether VF followed this rule (it's a
> > > > > should, not a hard rule after all)?
> > > > >
> > > > It is not a MUST.
>=20
> Check up on the difference between SHOULD and MUST in the RFC.
> If things break without this then you make it MUST. SHOULD is a
> recommendation.
>
One may be still able to work by having it as "SHOULD", it may be just too =
much of code without much use.
Hence, I kept it as SHOULD.

> Isn't code saving the reason you want to prevent VFs from using BAR0?
>
Code and driver complexity both.
=20
> > Even those cap check is not needed.
> > Hypervisor driver needs to only check that BAR-0 is empty of not from t=
he PCI
> layer.
>=20
> How do you check this? BAR0 size 0? Then say so. That affects all VFs and=
 some
> of them might not have legacy access.

I don't think we need to enforce this by writing what PCI spec already defi=
nes.
For example, we don't write how MSI-X PBA addresses to be programmed when p=
rograming a vector and how to memory map PCI BAR region.
It is left to the driver to figure out how to detect BAR0 supported or not =
for a device.
Multiple solutions exists left to the driver to decide.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

