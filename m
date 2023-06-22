Return-Path: <virtio-dev-return-13041-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DF2EB64D8
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 16:42:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9F4E67C6AB
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 16:42:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 918AF986654
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 16:42:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 84A8F9865D4; Thu, 22 Jun 2023 16:42:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6F8109865D1;
	Thu, 22 Jun 2023 16:42:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9ZBq/bqDuCR/riBJZA1ecspj3aWoublfa+mwS3VTw502T3KIS5HNTCcrxIDKFeGJ9yyNosfc9w9L/QDGAkNYizMndPiFJdN2GsZMLFEvuL1eaizXpmGoadbLLYWhAOUn0Vq2k+kJKpIaXD9NfWbsTYkJOoO5VN39D86N+VRGEGYnAKMSv6zJqQuKhQKk8jCRFWXF9BM6ndmuNHoCUamvIwSakZ2ZURAUvaju68oa/TIbsAhuhPIrd/cu674+5NT+cNuw3PYw0B3SjEi3k82ZWBe3Vf5CDkH0/3x9VQascsBAXlL+e2AohXc5HYd3QyHT3WsQhI0RadAIFf1Nmc37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/X/HH/e7WGzrbpgm0a+lYjkA08fszHRC04rCu4iQrLQ=;
 b=OGiE7cJHXJXCr+NDB/wbMlsIry8suPoK4tBEeA99MYyUJoy/KPEvWSvV7vZeoseDgeo4jpTYb3GZNlsojfPIIN497mUF11iy8kL5PTAcf3l4tbRJs/o4BTCf3XGZ2pxDJBgIaZNuws0JiJImUCo52nN7SOJ0KJGQgtrXvbbbEKAlnaRg6MnKMg5OdNCFieNr2ubkErK34MTh5HGMCeMfJ0iP7w03PmWk1EaL+y3iSCvxl4ayX6Zzrwv1fcor77EqdOBmJNL7HCiFjGgc444Tk+ZpdEEGN0x7i+KTO+Fk+RRLU6mNWr41QxyZNd/5Y+CNNvKhfS/nQdYuzovIlpyL/w==
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
 AQHZpEdpSlZ4I0eUeUmZIFkjtAkw3q+VZGYAgAASyQCAAC5zgIAAADyAgAAMJYCAAAHeEIAABAeAgAAB1cCAAKHPAIAAY0PggABFu4CAAAII0A==
Date: Thu, 22 Jun 2023 16:42:40 +0000
Message-ID:
 <PH0PR12MB54812B8DA2A17EF07CBDC3F1DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230621104647-mutt-send-email-mst@kernel.org>
 <20230621164606.GI74977@h68b04307.sqa.eu95>
 <20230621152559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481141E18AAF1BF214A0E29DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621161157-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C99B8504F02D39B3A6F0DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622120756-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230622120756-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB8901:EE_
x-ms-office365-filtering-correlation-id: b37cccb6-9624-4cab-94f5-08db733fb19f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jjgHxLL4LSTCgftOp5dRepcudpjV5zpnifhRDyBE/rOjVq9zzMFE1lTlHKylHZjrF+cuLFdiqPMFcQh0cgcjKljCBDpaZqYT1RjKg4WiQl+UZOwQdRWEhRDcWPHjQ5c41a9kEAyc7UQuAo5xbgr/BJPgj0poFGCXbJ24CdddPxA/0qkbnBpqCDy7euHTsK09xSEIK2tMm4tJmjXkY0C7no41+06fImf0h4udE8WNcZ+PljbCyHyMNRKfekwuWKnOFvDEFBh/dOnlnpPN8Chkpan29y4QO4oY//58ZE1H7z7nQq/5a0FaED8V7RkcpC+Sx+8dElLWbNtZhwY2VCUJisjBSsGOw1P3OEr/R7BU4CUpoEhthRW+49dhk5Lp/8a5qIWNz7ER8wE98lfnCDQBhGlx4iMQURMMNvw64UO52BejO4rT2Y0FoIsl6qud05G4hyuZo0v/bOsXNCjIo9/nyH4mm8+xTK++y7SHWOG1b936lziP0gvrHHVsBZKWWuMENQwxb8RdxrIkTM95TrrxAcx1+1wEhM/ZlHiwWgXTFWVxpz3P7pP2AFrTE0y2qa15w6T3btpCiIPfqwhwNjoGs92RMs+RK5zcaR2DnWx8wMuYVlulDuXK+31c2QDqeGqW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199021)(71200400001)(7696005)(478600001)(33656002)(6506007)(83380400001)(186003)(38070700005)(86362001)(122000001)(38100700002)(9686003)(26005)(55016003)(66946007)(6916009)(4326008)(66476007)(76116006)(66556008)(66446008)(64756008)(316002)(8936002)(8676002)(52536014)(5660300002)(41300700001)(2906002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N1sbzgkMISlCTsRTA+iRC7xeD64DI3J6SggPlZYIarQiQFZorpnoQsV1ahvY?=
 =?us-ascii?Q?ZwL2UDTJst2WaknppHG+qsmxaHZU2eZ5Zhcui4aDrEXFm/N3hxOmhsq912fi?=
 =?us-ascii?Q?vvCI3Ukr9SCAafldbM+QywtS8a42OmwwVDbpttd6AVzqcvfjOdY8CF1ziDE5?=
 =?us-ascii?Q?tz2b/Zl1Klbw2j7KabnOqkipcGprxn5YtUHURcdI6BbHC9fDnFN5UKYvVYeT?=
 =?us-ascii?Q?lya7fjd2Ss4WpTNcW+ey+OA0RuFqXe20GI5rzb0Vw2PixDeSSRmFt4AHkfaP?=
 =?us-ascii?Q?ZpI10Nm6nAm18+pN93ErVrcjDnzdqrIMuzvp+o5nMkkuU3RVFe3g7WIzGnCW?=
 =?us-ascii?Q?kIDCr02+7jO0zJ1TB3+ZNp5X1hKYVI2VUfx/pATSvXvJaPVdAbIzXKZK0XR7?=
 =?us-ascii?Q?7Qbg6p+UmQk0upiT/tJF/fSeRPZWH4dLGJ6PmhEdhRTcKaxbKTrkejbIGqSt?=
 =?us-ascii?Q?ldvVc0XUbEiCjLgAk/TJmmwGyPPDovsDh2zL7g1q3vOYIAqjOO0O26mQjOvi?=
 =?us-ascii?Q?qGo0TauD7BTMS+PF34CQ1UJ4iBRtWLnJ7RcYUnYLb+SDNBEiT08mei2VDy1G?=
 =?us-ascii?Q?evYMqA7xVQ5hp/ZG+h3UlK7eQ+EI6FBUOwQG7dmwFatEyckHB9V46wwAx5wz?=
 =?us-ascii?Q?vF/CkMjmwVchm7L7vki9WMjFRy05uZyOyCRA/2WGdvIlhEuKqVH8kjaoh2j/?=
 =?us-ascii?Q?woor118vdYIkG+IC5nDR9UuGamOExNxktVX4xUx8rBkpMX7zHkxwYutIgD13?=
 =?us-ascii?Q?F1ETghKD+vVgVRcRvhGMYTU9wh6VxtpgWAvAO2qQaM2F7XP/LwvVzsQWZsCs?=
 =?us-ascii?Q?nfvk4WbygUJph9ks4DM/b5hmpYWrVHBaChbBHveHKywLW8FN4mbD1p548JW+?=
 =?us-ascii?Q?gE24mxx5JBLWDpRvMu49GciOKrlcSOBAIJaiRqsOIURxwGtBzASRO5+ZMdkP?=
 =?us-ascii?Q?aCzNPgJMrQ1cnp4pCninuHzMsdWMcEgjPBkbvmVkO4KenwW9nQT/a9g5ggrx?=
 =?us-ascii?Q?rijn2r9FYpZhii+ie6Y3S8LESxNSTjMFpHlwciXbc3Dq8RWx87/vo74Z6+h7?=
 =?us-ascii?Q?kIwgV0Wlj+KdDdnrTyDuvWkU/TX3NXyvbkdtJsqX4xStdOXk5GdYBygSbUzb?=
 =?us-ascii?Q?9srz+7omqE2gPN8v7xictf4ZoDLFw+ScYZesGS69TvTYNDyj+9RRBbXAFvkE?=
 =?us-ascii?Q?c4RdQ+90/5KtpwXV53e5sc2361jNfB82hE419IsVTPGxJbp2ey/B+TnzDlsP?=
 =?us-ascii?Q?Cbrhckk3n087cvbpej9y9M6Bx7MCPCfEAP/PZUFiayzhItYCaBsWOctJgq9q?=
 =?us-ascii?Q?Q6cm7EbDvLIl9SAjiQXQMV62LmjwWyknxqx8E+znxXfcUpRNOP/TDgUH7ddp?=
 =?us-ascii?Q?6DcbJN0WZPhagPn0OLnR8g6duZD1fh2bReX2Fzd+ECungMobQvSJ6LzbSi8c?=
 =?us-ascii?Q?I53QtfBaU8y7RsIaX4I9HZ64DgGqEXyD1a40clyxqG0/Va1TLowdQCLpSpY3?=
 =?us-ascii?Q?8J8+uutH8HcQuz4fknyUC1k26xBoRKQ3B041rPEMLtM+dE0c4/D+UgzcIHCW?=
 =?us-ascii?Q?JO/ghf98w4R5UXYWABI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37cccb6-9624-4cab-94f5-08db733fb19f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 16:42:40.2879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kF8dtrVoGi0C6YcpzssZLcpDoqqu91TKpOaHJfS0Fk+2e3KENFESIFCowAJgSZGvzrAS3AMIecLDYLOdAsoU1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v18] virtio-net: support inner header
 hash



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, June 22, 2023 12:28 PM

> > > Not sure what's the implication?
> > Implication is device needs to store this in always available on-chip m=
emory
> which is not good.
>=20
> Oh by devices you mean VFs. Now I get your motivation, at least. Thanks.
>
> > >
> > > > > For example, for migration driver might want to validate that two
> > > > > devices have same capability. doing it without dma is nicer.
> > > > >
> > > > A migration driver for real world scenario, will almost have to use=
 the dma
> for
> > > amount of data it needs to exchange.
> > >
> > > Not migration itself, provisioning.
> > >
> > Provisioning driver usually do not attach to the member device directly=
.
> > This requires device reset, followed by reaching _DRIVER stage, queryin=
g
> features etc and config area.
> > And unbinding it and second reset by member driver. Ugh.
> > Provisioning driver also needs to get the state or capabilities even wh=
en
> member driver is already attached.
> > So config space is not much a gain either.
> >
>=20
> Absolutely, that's why we have admin commands.  I was hoping for an
> admin command that basically gets/sets RO fields of the config space.
>
Admin command as I recall are not accessible directly by the member driver =
to the member device.
So a cmdq or cfgq is needed.
=20
> > Instead of decision point being RO vs RW,
> > any new fields via cmdvq and existing fields stays in cfg space, give p=
redictable
> behavior to size the member devices in the system.
> > Once the cmdvq is available, we can get rid of GET command used in this
> version for new future features.
> > Till that arrives, GET command is the efficient way.
>=20
> I understand.  I just don't much like these patchwork solutions though.
> And I don't like that we will pay by not having a single conherent
> way to provision and query capabilities through config space,
> instead just for this thing we will have a special thing.
>
The single way for every device to query their capabilities is via a cfgvq =
for all new fields without extending the existing config space.
(and optionally old fields).
=20
> Why don't we focus on a work on a full solution? Just don't implement
> this thing in your devices meanwhile until we do.
>=20
Then Heng needs to wait for cfgvq to be defined to be implemented first.
Doesn't look reasonable to me.
Current GET is coherent with the new commands defined such as notification =
coalescing.

As community, we should work on defining the cfgvq, till that time have the=
 optimal way to get the config, i.e. using the cvq.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

