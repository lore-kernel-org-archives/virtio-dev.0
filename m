Return-Path: <virtio-dev-return-11714-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E90FC76195
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:50:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CE7FB2A81F
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:50:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C4DEC9864A5
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:50:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B7B0F986460; Wed, 22 Mar 2023 16:50:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 928CC986450;
	Wed, 22 Mar 2023 16:50:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsmHwKHtcovL0SiY5VkhVn6yJimYsI7S9FS5USGnnIBvg7SbfkaXFrR0g/M5mcwRcNMycPTYwWBNMd9m45ZvC3eY0idkqeFY8NQzEjAlqRQA9aPAqXxHE6g1mtn7l0YWBmsH7uWaIpvNxb5GoTkGMGbHWy4WGTuPAxIggF7g0K8Edql7+5gWgFhe68nul7B0jcdayr8zVlGtYTY/oOAzWzIWSGH15ryLXfyZyyJ1YP6RLHoNpszhKkaPwpeDLG3mnILfDZ0wi4tH+5EtTCSEUaIdIkITPSXZUjBEOoOu/QyZ2IpmG4lWXphq8Dihrdjn1US+RNqZEmOJv7otyEBaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxfbF9HW+Z4GAs++2CzArQgn1gjkd/vpfRTkgJ6rItc=;
 b=F57gjHjTJ7zd3GHsa6Layf0cDZeKIIZ7rFB3QtunrlgqH69jYwWgZ0jD/tODvpTOAJdiJ6HPpFLi6TxMzUJ+NdxRGOHnmSWkDr7xOuZfQfkEV1TfdmhiSxHvpNuf188hyChshCnfHJSXPfaaAQCJCVt30wArVERAGGqASskUjBmXgg0Hfs6En7Y+AG4GCgn04nVPp4HGVdDirdqxqLtHeE+K3XwvTGABaM7cmjzoHjQsvMvYFWv/iUbJ/o5ztSKsel2Smgura84DPEbI6weptvuLjt8k5RxkiFWOWJau7lGKZUXustJmvnaUBQ2geEX45vFGJL033f6TwOjtxNIOeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>, David Edmondson
	<david.edmondson@oracle.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] RE: [PATCH v13] virtio-net: support the
 virtqueue coalescing moderation
Thread-Index:
 AQHZXL0YQHWs+6YDyUK7u3Kjjs+HRK8G6jaAgAAQ9sCAAARNgIAAACrQgAACBICAAACoAIAAAGVQ
Date: Wed, 22 Mar 2023 16:49:58 +0000
Message-ID:
 <PH0PR12MB5481B3FD31F529EDF420FACEDC869@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230322125153.128385-1-hengqi@linux.alibaba.com>
 <87sfdwhkxq.fsf@redhat.com>
 <PH0PR12MB5481FCF22C47F2D23E6638E2DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87pm90hhew.fsf@redhat.com>
 <PH0PR12MB5481C1E2C473B2F13D1B8D84DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87jzz8hh1w.fsf@redhat.com> <20230322124508-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230322124508-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB8272:EE_
x-ms-office365-filtering-correlation-id: a1c98a50-11b8-44b2-8a70-08db2af57906
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gqDNOt5bJlf1S3fFWhMT1A4tG3IeVwgcPRmbDy3UpMYooeGnMNVK38Xi0gvLL5b8LURZuVGnp8T9qsapJwYF2xftof1wxYB68zuE0b9m/Dsbs//On94I/Vx4aT2v/3G6EhNjxQ1eTszcH+ByqVCBwcahyx5xtpaEHQ7xa+qkTCwp3Fe9wdhVBNgTd2rq2aJj1hN5nheZru9puyHKV3gilrbBWaUxHPZZgPiU+Eydo2DY0QLScLAAfsFE5IXFMLNnFbeq14/YLnIq8W3b/ps4JrFaLGam5dLhm2hJDbXj42HNeN663eWwHWruNE+lDvvZZ6ob8/B6xhws89jv0vl/fBmNkPLu2vmtdsDJBMvg20kuaNP3DivO+x5TndbmKwV+fi2McDXNTiH/vLa91xAmZksgwyhgKQ+ML1jW4FY/3f/k+/d1WY6Q+BPeNx5SXBo1OviQH/A53sGjE497ERyWL5fz56k9k/kYhFhLe7AebeC0NR0AXTEaEcl2eT+fm5wY+7D016YANa/M76YnMMWn+SvR8f62KWvYkZg7p8GhYBZ3cRSZ43uSrIbxIoxqo5ZB1yBQSRdrZyfavzILddP+PLgQaEGQWOxx4wyR84GRI8+Ug/7WD6dWgA1k+FFvz6fXq5iGZZb3GZMxG7JgiLiqomoEm24lZ1JHdKWbl2s7BjALldrsAZpcwL9IsD0mhrDk4C9LKohXUF7Q0RmHYxudUQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199018)(316002)(110136005)(7696005)(83380400001)(38070700005)(38100700002)(55016003)(122000001)(86362001)(66476007)(8676002)(66446008)(66556008)(41300700001)(2906002)(4744005)(76116006)(4326008)(52536014)(66946007)(64756008)(33656002)(5660300002)(9686003)(26005)(478600001)(186003)(8936002)(71200400001)(54906003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tVD9HQiZOirw01PLIqAhChXTR2PeHZ4xrxEhxkNSZqRizFLI4vdp2fCRn2yu?=
 =?us-ascii?Q?kIsPpK7GPdIHDYo5nnwwqQil6tF2FGXQrdW+jLqCC8eqLmfrS3YeDeWoTlil?=
 =?us-ascii?Q?MKHmP+4DOoGggmHuLxLhCGCdaA3FOftjrFsY4cpcr61H6iod1zXzkZcJv49y?=
 =?us-ascii?Q?ptBMoJzCUCsLYy8Ar6gd8QBZhRj6LQHgGiQ9C1Lx+WHNd7uUqWX0+hNLOnM+?=
 =?us-ascii?Q?Ct4ECCjm+oorI+swWuCVCBGNOxgTIoTlC7tFCHaWAFbmLoj4t7Jj64W0lZb8?=
 =?us-ascii?Q?SOn2illkyhouu+iAnaIZLQs/StaAeK+mxPN8CHQPtfHcl0vytN1LkIXYkudE?=
 =?us-ascii?Q?ahJ/MXrg8NNOQeZXMc2lxaszNYGSjKsLMeaoVJJ7hnrmmI841dbIfE7sGfsk?=
 =?us-ascii?Q?NGE6HEj2lvyuNCn7GXMGTZZ52gRSoIowuxShjk/YeYH0BfbsFyz2bT2g0ApI?=
 =?us-ascii?Q?KGOueb5VEPuuUKKYZaPJD9KdsnS1AC0hpWZFzBxDtEXXTVnUR556L/w71iSX?=
 =?us-ascii?Q?LLcXSYyYOuJLN4OHtgJwChj2p2DoDSQ7R0XISGXovofOuOPxhLUOdAfc0zzW?=
 =?us-ascii?Q?IF02Z6NKWoFqeyYGhqF0Hdnh2OuTvse/re7u1QIfgfHVLFlnjszeYDRrgxo+?=
 =?us-ascii?Q?YDEz2Sci7pfC4v2Z4pUMM93ibktE9P3k08M8/HXo3XBtEZI22YDohyC+nK4n?=
 =?us-ascii?Q?qBRJRPb1FQ5Qr4twrCWt9Ar780I/vUBv8GGCOTjWCQl4IwiSLP2HOX7S4kpG?=
 =?us-ascii?Q?PhpPq84xFBt8dyrbpWuC2XvfBnzLuoI0DRFH0xnr0uTI0+F61rI2EbHHCEZ7?=
 =?us-ascii?Q?YB5GQ5jExkwKcxJW2kHPgT8/+MURg9V6VRO23UqrMLuc4+MwWJVOQW9eE4Va?=
 =?us-ascii?Q?rt4uc2iXU8kPL2i16UXA/6cdXe84Ge6/G0dFBATOt9IubTMe8USWxhTlQTsk?=
 =?us-ascii?Q?6fZgYpilNxzOQvVNON6p9ShO9DiZqr6OH8KDlu/WFtW3ulPMPpVIEK4nEm1r?=
 =?us-ascii?Q?tf+ZCsU5wuSTgm7zzbgJjTDQv3smvdKk/5NszEAQFSEWXgXirRXG0BnN8eJS?=
 =?us-ascii?Q?dxbN1abGvXAMEgHoLBI++qf9knLlrFLq2OdB882mxqzOmRL4Fe8Hqw73pb2d?=
 =?us-ascii?Q?Vk7tcUJdgGAUhpMqLKISDmafvZ75VOo0RUwjr/YXxqPkU3UjZRm++jXEkudr?=
 =?us-ascii?Q?L+rNt6zZAUsz3r5PrP58CyDHCV82sbujqOI3YZs5i2VMT+7/jzKIQwRKK2GW?=
 =?us-ascii?Q?4ZFQiiQ8nBaowmawqXkShNAxx1xV38wDU5twx7DwDOJCWWuT4CIeigSm2ITK?=
 =?us-ascii?Q?4PM8pzciSkpSV3goGAw6PIIOzo78gAzjWenuDU8W8VCtd8aMImu1ZWM2FeyL?=
 =?us-ascii?Q?0qapRIkaXNLewTGuTJZAHqiaMRGu8AEAE9kYMmSEYfGYms8IzuYf2V0cDBS1?=
 =?us-ascii?Q?ls9kCixiC2vBGREWSUNapgHJkUE39srHkBfpT6MkdOZYadUgAcb9muEMc/qx?=
 =?us-ascii?Q?k5uWry5dYiosuPtZbgIpJYsgUfx4YJ+3VrcpizXV4Go/E3+tR41wKKIOSrC2?=
 =?us-ascii?Q?vJl1AqkUQCtaq20WQ/o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c98a50-11b8-44b2-8a70-08db2af57906
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 16:49:58.8258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Amw6AiTJOgHNR7cY3a62eCvrCKuod0kyh3XVFjjqD34hltUK6VcxAW84ZBpnGJGa5jzQINrvqYQg920vHKCIrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v13] virtio-net: support the
 virtqueue coalescing moderation


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, March 22, 2023 12:47 PM
>=20
> I agree with Cornelia here. Yes if devices do not want to trust drivers t=
hen they
> will validate input but what exactly happens then is currently up to devi=
ce.
> If we want to try and specify devices in all cases of out of spec input t=
hat's a big
> project, certainly doable but I would rather not connect it to this, rath=
er
> boutique, feature.
Both of your and Cornelia's comment is abstract to me.
We cannot change past.
For the new command of interest here, hen driver supplied incorrect values,=
 the device will return error.
How to implement is upto the device to figure out.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

