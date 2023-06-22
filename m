Return-Path: <virtio-dev-return-13046-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB77BEB64DA
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:05:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2AE24419CA
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:05:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 74BBC9868DD
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:05:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9F838986602; Thu, 22 Jun 2023 17:05:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B0F379865D5;
	Thu, 22 Jun 2023 17:04:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtQan6Mpn71R+u8+XA7c80wgnFy7IQm4FTM6YNEyrIgKYyWdJpURvFNArcErvaiiHKUwMZ/NeHgM03tP0Jm88VV3+ey4skhQfQRhwBduU7LZfSc3djIQ/6fLHZ+bSqdsMwlYEh8MTW8eOPGzYoIu6/+xJEs90YtxgDgCe1Ok52uvn8xFJlEVv+FV9Z3WYjy0BjNXlptcuqbOqNGHXdlJspiFzK3G3wZVphEFRm4rz0VkkOL5at4NsuY5zIGv0iHqERAIhWvrCg/dULB6fbCbi7UmZPQyIRN7RWo0H9Z4NbiFDw0dpd+zkfZFEeKIANCwUHNf/UFnh0liJZoqEnGZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQAOsfxXp8oclJT+zHn1aNN/FFv4IsE/K2u0hCcQZME=;
 b=kR0tfA0zzwHH2l4KOor01xMSL3XhEfjwja871HxkBdbpY47+OSq8nv5z6YV7xwIvgfRVP3ab/h2E9JuUGhI2lYiHqyEhf6I6cJXG+ksRADABXDIQCvTApONAeYschJAo2qxqbGi5y8W29EsSyiwRLWFUM9GFYfP/pFKaNKxTuiISHCrXW1ZpkF3XzyIF5oCDALeVFuVzMYUZ0HSTyYpraZCf5X/LIqxgWRs2vu50jrb73ou7WJ6bbFCl0Y/av4KL20BLK6Fk+Ozk2UAl6Ebo4F1yang8tSFlV55A+Ik5bJKA3DZ7QhN0EQkS3YvtpcVKquVy+ZzeO/ayS3i1XZuv8g==
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
Thread-Topic: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net:
 support inner header hash
Thread-Index:
 AQHZpEdpSlZ4I0eUeUmZIFkjtAkw3q+VZGYAgAASyQCAAC5zgIAAADyAgAAMJYCAAAHeEIAABAeAgAAB1cCAAKHPAIAAY0PggABFu4CAAAII0IAABUeAgAAAscA=
Date: Thu, 22 Jun 2023 17:04:04 +0000
Message-ID:
 <PH0PR12MB548183EB6CB52E3A719C27ACDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230621152559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481141E18AAF1BF214A0E29DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621161157-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C99B8504F02D39B3A6F0DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622120756-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812B8DA2A17EF07CBDC3F1DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622124701-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230622124701-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ1PR12MB6313:EE_
x-ms-office365-filtering-correlation-id: 062abf21-d3ab-4bb9-ba14-08db7342af37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3V+AMtPjs45OP2MCzn1rI00DmalBvAlurAU4n9dJGe0HMtNahM9oD3ygZpCImFwIoUjIMepZYgJx9ZxQ+M4FxTupPMpzNa1NfKbEYPOilu5c+WL/pNRJ1de8TeqJIy9UCW1hcIO/KCSXCENIqNXj1t7GSEffGP6+DNx+T2eRNafIh9YPSFbAcsR7+c/qlaRwpD8DjgVkANR7nynCs8133HZB0231NMLw196DbgnZGAZofhxWkJusalgvtC9IV54Bpq8etHbIw4dDwsbokmco3wOCG2ckE2Lx+E92Iq6BEbwS6Os4m9YG/TWqNdzI2GPq+xg6XHpDMSSxYUKZr9QBRJjrloX5rqZxLDfqOAHuQjwId8SfQ+YeWqXSnsUN9Pxq2TOmiKv4jIYW79Vh9rKlAD88SJ6XkpILnWmPQQzKHwVe3mJnu3FmLuYeeM34GOfKGDdiB6CqzOjHSQXvITDE+Ot6ExkVDNuG8SQJOSXp2f9KawG9Kr+tbihTT6VHJ/4ueO6/GaDxFw3JW00alh6opwlOchs61wUXNtyaQTfEuZQY9bgTOFfPv90zMgGywl8KK8OIM8VRSjQ+HfqQVqRpfV9M4xW410DdrMk27zhR3ve4vx3cwD80Fg0LwCAOLHBL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199021)(52536014)(2906002)(186003)(83380400001)(71200400001)(66556008)(9686003)(66476007)(6916009)(66446008)(64756008)(76116006)(66946007)(316002)(7696005)(54906003)(5660300002)(8936002)(478600001)(26005)(55016003)(6506007)(41300700001)(8676002)(38100700002)(122000001)(86362001)(38070700005)(33656002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jIIzgUbJtOR/8N/EPGWryICi1xLsYbGfJVpKTRVtvjATbVvJ84UZmezhm350?=
 =?us-ascii?Q?PVLLZ5kVX4feeSqjHKsc+NDCzR2nkLC1DmGgiWD43QglhVSBg44ga6onN3Ht?=
 =?us-ascii?Q?0eWZ4jWsPc8vhVYEBK8BaiAOxJHjgsCXqAEE02isT1Z+DF+ssDtYLs4LD08O?=
 =?us-ascii?Q?MnsfsJgIHQGwoeYCfAsEX+0rei25hS6Qys1NX/5FnpTdu1wUyXUt0Zkfeljw?=
 =?us-ascii?Q?so6iZBOXHj02oIL590SIn57KGY7HSboRtjOHao2XAUKSayJByDGJY2bzKnZr?=
 =?us-ascii?Q?4G7XlEfsca9+r7c8BQk0+paTi/pJVQHmQT8HpQF2rXu+JGL9Eqa0fjbnwpWy?=
 =?us-ascii?Q?Y6TLLVIHGsjHH6QigRRMzBKNhadWVWpo4iKPvX6iUmRVLNCbqXysdua8icRi?=
 =?us-ascii?Q?7s0gKw5AE5GqsZPpzjVOEfCPh3L/Ju5S4p8mdeWX7AKiGCIxab/VJ3TJoL27?=
 =?us-ascii?Q?iFpbO5l5925VEcaLaNbnoi/mmVpaweeIZIHYoM72ABm22RoXpmNW0XhZBYNp?=
 =?us-ascii?Q?fKmpTuGCqdWilMVGLEs8rC/eofWZcvWDtMqHWGDz0x5Zp4gIZVnkwGTpeb3y?=
 =?us-ascii?Q?+uojuv+yaAfOD9iphgiCLYC+DBm9es518hFkRE+Ask7KSlbxqPfghSl8OUX4?=
 =?us-ascii?Q?5ROjMbO79qZCNlLOwgceJsXNWYuDIiyEBmM6J0FGIOofuQj9O+VA1qCk14NW?=
 =?us-ascii?Q?FKcAzEcdK1cRthRmHgcvwkwb5MVto1i2K1xqTct/hCksb79Y92Q1vWuBImu5?=
 =?us-ascii?Q?NWP+MS/8XdfrVclpH9AgowvZRhDys+8o/t9h3k/TC9Vo/n00DbHI7h04iYA3?=
 =?us-ascii?Q?9f3NbeTrpAkLeR+XkG2TJlP2UjKVwfv1uUGGuVRRK9s+yVconDvw7tulZv4N?=
 =?us-ascii?Q?bZRn57py9hkIRzKtc8JSga2nhFkme0KU7MEzJzDcOrZI7aZRtc+3G1iWl64l?=
 =?us-ascii?Q?zTyLauhHouxvEvu4XASzM3AcV3MHWNMU4cd9ZaEdSLDwVCrLSRsDbCsNeSih?=
 =?us-ascii?Q?7GCLVuSoO4YFqi+PfIcRWlom1o07IvqAaJGs5msTquBUzZpAlZTKo2vUOir0?=
 =?us-ascii?Q?bxPYuXdKEmxCUlKu4AVTsIMzBDFCeR7IUq6JCBiwtpE2Xflfyo3Y5R2htqh6?=
 =?us-ascii?Q?kfNGiObt5xHZooe4Qa2CQaSNWYnQ+SVXJ6fH+Tm/YXbuKy1xksF9lPrkK4GJ?=
 =?us-ascii?Q?aSMBUFwEsGx7wE649obgb3ma+F5lImcitwb5H3faFYpKx7jQay0YGxjwv7Nr?=
 =?us-ascii?Q?aYC4isiqVf63BozZBPM/WdV69ubfd88tANyVYw7t9hCksJYhXnwNPOx68FKw?=
 =?us-ascii?Q?AglkDkYvCh6fVCqRdW9BnYro2q7x8FJnkLD4ghuJBGJF7v4HMcKgcXFnwugX?=
 =?us-ascii?Q?dalh+kTXMLwBowuTQnA8p8PBeRF0DIwZgqeH8tnfabVEZdKVL/4opC5XF++B?=
 =?us-ascii?Q?+Pg7lziWbR6NkStVH5dhZT3b3/99rSo9HCVTHZoXIDBYcP6t6oNDQYUve7Vt?=
 =?us-ascii?Q?AnSqpxVK+WHTQeMl9qzw0FwxmJtuFO1+uFRZOPkb1DUmtyJDw4hFrzVYCe8Y?=
 =?us-ascii?Q?ZPdSMDyHzvfi10rGaAY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062abf21-d3ab-4bb9-ba14-08db7342af37
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 17:04:04.7674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h2ZQZD8PE1Jy7b1QtX4P2g8wWx24/XvIPVUYcZ5dzYhb/OKpS8Nx+wUv8pKte98RJ2+hTK5XwdcVJ/FWUMRIeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313
Subject: RE: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net:
 support inner header hash



> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> O=
n
> Behalf Of Michael S. Tsirkin
> Sent: Thursday, June 22, 2023 12:54 PM

> > Admin command as I recall are not accessible directly by the member dri=
ver to
> the member device.
> > So a cmdq or cfgq is needed.
>=20
> Possible, sure. Or we actually discussed a self group. I took it away unt=
il it had a
> user.
>
The problematic part of AQ is that its index is placed in the yet another o=
nchip die register that does not scale as each member device has different =
queue count.

When admin queue was discussed, it was only for group owner, (you answered =
to Jiri).
Hence the scale is relatively less, so it was acceptable.

Now having unique numbers for VFs is not good.
Max proposal was the last index after existing defined VQs of num_queues, t=
hat saves the storage space on device.

> > The single way for every device to query their capabilities is via a cf=
gvq for all
> new fields without extending the existing config space.
> > (and optionally old fields).
>=20
> Or adminq with self group. I like this somewhat better because we need ex=
actly
> same query from owner.
>
Yes. this is why I proposed to name is cmdvq that can carry admin commands =
or other.
But fine, we had to progress for group owner.
=20
> > > Why don't we focus on a work on a full solution? Just don't
> > > implement this thing in your devices meanwhile until we do.
> > >
> > Then Heng needs to wait for cfgvq to be defined to be implemented first=
.
> > Doesn't look reasonable to me.
>=20
> And *everything* has to wait. No, not reasonable. We somehow managed to
> release several spec versions and things did not ground to a halt without=
 cfgvq.
> Don't see a reason to do it right now, what's special about now? I feel w=
e should
> add to config space and then solve it all.
>
Things didn't ground at cost of device keep increasing their memory footpri=
nt.
The latest addition I remember is the queue_reset register.
It was bit but a purely control operation that got in there.
=20
> > Current GET is coherent with the new commands defined such as notificat=
ion
> coalescing.
> >
> > As community, we should work on defining the cfgvq, till that time have=
 the
> optimal way to get the config, i.e. using the cvq.
>=20
> cvq doesn't really work for capabilities though.

For the device itself, it does which is what is being done here.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

