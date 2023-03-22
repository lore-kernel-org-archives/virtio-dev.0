Return-Path: <virtio-dev-return-11712-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F238DC6FD1F
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:46:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 548002AF89
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:46:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4EF95986475
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:46:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 442A498644E; Wed, 22 Mar 2023 16:46:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 313FC986450;
	Wed, 22 Mar 2023 16:46:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iiuk4LH2JakhPnx1gBsmbOfn7a7uZ6nOYc0up/HTpYLCBZKERJw2Fx6AaYD8jv1CczWXgJYmoWXnsdn47THHdKkKP4gENWM3vSnnmVgZRz+AAta8NWwcf3IvGwTfpgicp4Rla8U4BjGDHhc84fBYKHxmQeGdIwq8Ih55iM8Rj7COILloYEiI+Qe2iWkPjipZU0v9xCENUKRKnaC61YAtO0VBObvgX++Nj3N+6Vq1AZJQ3BArOQ1bUkz3+tz3g1fBz/SdwjZSQvNq9b1pwBxAaNRU1PJrbYzEZTAb71ENeKWKZ7R0iNeho1HJXJwUjx440S63C1DfvxQveB7Aigd/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93nQoGwrznvW3+7ReOuGkoBGf4hySNDiAHgI4dWduBU=;
 b=Yx8loCiZ6+FOCRDvEPBXFjhhIAV3dDqQrFrcAHb0+x+bDYzOMkB6lgkaf1FGmn0FH9o9onYagCtCyp/kebCcmJUORu0H+fR1UL9iCzO9UscXyrrb7sdM0ZfpMkK2LAVVFiWFjHsh2RBGVXgY+IA7Op81bRCdXqCdWf5BTPUZ9zdQPac3xBrlXH85yKntWKBEiSk8du5lNPcSz4G24uGKDYay6Z388IiJ9lNdQX8SI4GzfNcOqpY/gZ1gSM/bHfrh+DbacvMzDC7KXpgf8hA/mMBETwH2BGlptvBPSnYRKaY9gRWw+havTVL1BoLS/sml6G3l+2iFKhy2Kre5KskXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>, David Edmondson
	<david.edmondson@oracle.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] RE: [PATCH v13] virtio-net: support the
 virtqueue coalescing moderation
Thread-Index:
 AQHZXL0YQHWs+6YDyUK7u3Kjjs+HRK8G6jaAgAAQ9sCAAARNgIAAACrQgAACBICAAAAw4A==
Date: Wed, 22 Mar 2023 16:46:36 +0000
Message-ID:
 <PH0PR12MB5481F9FF6580D1F8847B9D3BDC869@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230322125153.128385-1-hengqi@linux.alibaba.com>
 <87sfdwhkxq.fsf@redhat.com>
 <PH0PR12MB5481FCF22C47F2D23E6638E2DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87pm90hhew.fsf@redhat.com>
 <PH0PR12MB5481C1E2C473B2F13D1B8D84DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87jzz8hh1w.fsf@redhat.com>
In-Reply-To: <87jzz8hh1w.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM6PR12MB4299:EE_
x-ms-office365-filtering-correlation-id: 1dcd7362-74d5-463d-69c8-08db2af5005f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 99d1Z0oymORIzxRuA2aKQMjG+KHBJXVvFp1iJgrD9GjypRzOLChSOntDU7AwKySbTcoXzD1T7WmV087HEo5DR4ggZuPHWnICWeYO5yBI9uGT4cn7J79BqEjD++ufHvL0IuiQUpdvLueBlzu30SazOFbVRQr/AmTyy3r3/9Svye2/B9frCoDXHV4JPNsYFZbS1MoRnNTih7P+v8S0NZsxlZe/M5rkmSr7P8V42rtaJaORLESPPJoHUWluaElHXasMuvJl8bhg3lkkm+sywtz9wPGtbn+jfXuSMq4LL5X4OJsVXN4wFDitmPSF0MwhRd+lvrbbvWvFv1qxKPJtBa2z3YSZhHpudfIeDnHqMeOJ5gkrOtc+B8/7aklTWF5jVO6n9ZW4935Q0zt1+Cpk1VdjzKoQw+mDQ1h+b1FPBDxC5Cr/rQp+9FP1gj7tJsE1qDLdG29sqkkkyrd12R3lvIRofanoH0U5SrCWCDMyd0b6gE+4puCw6U13FjC31owIZohp7tfMMKTXVxYUJF4ROIKxBBeoixlQ57FsRumA/VOlYhxgkLoT10wvN1gCrrmjkKZNujG8YJWzJu0Il2rCIAcFbWNTAVvz8aaRWHBrMt/9ZzVtCIwfZ0H1JutapD7Z9rbU4GNrAPMXwYrvI4VsFey1Zk0swfhGSa073PejkpvkJg5tw7+zvV1y7DeoLbbKFBEYOyAgqWRZWx6861wouAHQaA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199018)(86362001)(186003)(38070700005)(6506007)(66899018)(26005)(9686003)(71200400001)(7696005)(38100700002)(2906002)(478600001)(122000001)(83380400001)(33656002)(4326008)(66446008)(55016003)(76116006)(4744005)(8936002)(110136005)(54906003)(52536014)(316002)(64756008)(41300700001)(5660300002)(66556008)(66476007)(8676002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IKAFWMnFKchClGgu7kHmjjoXQV8kXqK+m/A+TGcv5HbVzQj4F10jbwBMzp27?=
 =?us-ascii?Q?v/NckVnEp0Bs2ZH9szDWvsZSGRm4PFipKVkyjDUB/wyUv4QluZztb3dQy+/J?=
 =?us-ascii?Q?eTx4heXIUwCHFnSAthB7wF6PxsxtqyMGO425hgtzKNcSlmVGar3gfSRAbzvr?=
 =?us-ascii?Q?Pr0iJC6FU0vhl1Bjt/65LeajGywL88njbHdCxbArJHctOMO7VHqvpZDw9nWo?=
 =?us-ascii?Q?hByXGeIIY7LP5OV/719m28qE+uU7rceTmeVu7HHFwlfbLyixeKF6xVpQUVsh?=
 =?us-ascii?Q?3B9LdFQCwscR9lnEcVx12g7omGsV4sEVlxFodvdrEJ/rJrKqE6epzBKn7gIG?=
 =?us-ascii?Q?b5kNr5DBkHeUpg04d8vqtLLkBcD38/b8HGaoVI48+7MbbjSSzcyDI2qfrXhm?=
 =?us-ascii?Q?gU+J21WvDnGR/IrBVZQlk8VD2Dv/67Jntwlp4Th/w3quZeSJmKetQCTpsGfB?=
 =?us-ascii?Q?Ieowv6D5EA6j2LndkS6cYw1VP70tE45Lwcl5thN1aVq5AaP2fLMbePVBhXHc?=
 =?us-ascii?Q?0UDKKmU4M2sxjhOIy1XEaaUnvblr7TvW3aW1tmHjEpMmFKkEQkVL5iDUBZSN?=
 =?us-ascii?Q?osYjWQ8vX5vFMVFg8uCjSqbqbAbcvsLO1vRdQV+gyTEo0JYVEqcwg/mf6T7U?=
 =?us-ascii?Q?iQOj7r9b66aYcG2VglqF+8GE+kI4xQzrpde0iPKzoR1KH0CxVIMehzH5tB3M?=
 =?us-ascii?Q?hFoc2I4QU64/BR0sRz7JU8jaV9hqrWcX31Bkg4aGsK31sdGMWxAF6J5ecxE8?=
 =?us-ascii?Q?reAN9R9Hh5ulGhXWAFBzaAyN+6/G8Da2SK1z8ZdIBU4FmMte1reQidHnWAj+?=
 =?us-ascii?Q?c60vew9ZcJHWYJ++k0ksSPZm29GKGWTJWYEJ3Ivd6GF+qtk/Z3jKB1/mqZ1S?=
 =?us-ascii?Q?POSHOh0ljm5dOhCO/VbmrtClCv943cIkvf52KLxq+9TjHqZzVRRfXtHx0xdC?=
 =?us-ascii?Q?rFVQnOe3CK90uLOWggG2v1APa21+0leDEQeDYjfAPKOESUc8+8RPdtbhuVz5?=
 =?us-ascii?Q?TfZRqP7PKbyDNVm/jsjf4emjfqfp3jdAzO9gErXzfgW5dvmxPVycgpCVEbCb?=
 =?us-ascii?Q?nc3pMJm9XeVNXXUBs3MCSeo6lfOt8xeb0u0+k5EEM+gPYvBoQDwGdvy1Om96?=
 =?us-ascii?Q?X1lorkWEn/hxXagl5YVoqD6KZKtjpgPyf+EIRVAeq6z2ulMTigI47BvA2fYh?=
 =?us-ascii?Q?JKqh+rcn5zQDHbJx8bElMBb0ZFMezJwu4af218DUUn2Va7LR1FO+4EkX/w4G?=
 =?us-ascii?Q?i/qhfaRdYq2Cc9wdeyRSqYf0vpsom2ETeNmKbYZ4Dklzkt5XwMASJsYQNOCv?=
 =?us-ascii?Q?VME2kMI9dCFcO0ZqywoeHV687/EVCcoK17unxbLAZxmo1odiF9sBt8N5zO/p?=
 =?us-ascii?Q?wLa5TtjHIriv2bMxl2pziAh37Y+z8YyDzKrvG8pQmUF0PsLbxMIwn6Xnhy3T?=
 =?us-ascii?Q?KM40kI7nBDtZj+6u6G+5qCIhPwHz916/BJF+0e2XIBtBiz+CBjTPF49RbGim?=
 =?us-ascii?Q?W0uVfSBJ/1B4nGnE0S4ywgpD6T/e6d2TDST1fn6eEbPJTGsXragKX7jGyeeF?=
 =?us-ascii?Q?j2okRWvkBWhJgkZQkmE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dcd7362-74d5-463d-69c8-08db2af5005f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 16:46:36.4195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eLixjCctwVpz/I572wsmVqE0V34eKkYEqlrd/ACfHfNt4QYpFOeGqNule/+4r+IP19aFlju2CUn9faOXNnVK5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v13] virtio-net: support the
 virtqueue coalescing moderation


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Wednesday, March 22, 2023 12:44 PM
>=20
> >> Well, I think we want to avoid having to add a normative statement
> >> for the device, so we need to be strict with what the driver is allowe=
d to do.
> > Drivers are untrusted entities.
> > device normative statement is needed, it will do the checks anyway wher=
e it
> is applying the config.
>=20
> But isn't that implementation specific? I.e. if the driver sends junk, th=
e device
> needs to be able to deal with it in any case.
Not sure which part is implementation specific.
The device will deal with it and return an error code when supplied qid is =
invalid (of cvq or of disabled vq).

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

