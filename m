Return-Path: <virtio-dev-return-12932-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F02EC7EE2E
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 20:18:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 84FCC2B12F
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 20:18:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7952C98644F
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 20:18:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6C0BC986418; Sun, 11 Jun 2023 20:18:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5576798640B;
	Sun, 11 Jun 2023 20:18:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kydwXvC5F6qYHokodc4rAczTpWvWxRX5n5Hig/MoxzJVkQgTIFzNNxbTJcuKtMXOpTLi99LlJU5uGSoPW1Cp+7lClJE7Puy9Sf8lNeWomPPbDV7Kh2l4bjLA/bBV7LqLoDqifaQwYd1I9Q+xP8rSfJ2BXT5Mpw4wbEz6LkmRjErQC0x3vzRq+aaF8mWW3ihEGczEhE4n1NOaZXZ4243ZMn6C0bx0QvMh1wpl0IOsfKK0b2keqKko3Rsap+SC3jtdMVcrEnwRrD+XRZUwm4eleisq1dBsG5/aSldh0s3IKhDcPU5ZYRetytjlBELIKQVEl5uEx3nJMIkR/4celsb2IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WTlaV6zRrBOc6J307FnbY6euG83S0J2lWYfZYtJLsA=;
 b=Bl6Z68MJXfBs5/wFOourk4RucxHUS3IeUZ8CdNNezHW/H1DeS4M4uaUY7CSDSltgRxV24ReGEA7zSKTX81eeDt2AUr08op7BG33LPegLWvOnDMWxwkXEKgvPqBgr+lr/EEG37ItOAL73ThFaP5hmcvwcXLx6aVm1WjD9g2Agql7qNyhZRgTNN6ctu6yWxoO00M+y7hyJwFeqPCwu8scRd0svawK4xZLCxmRd2rVIhh/efNbk2u/LJ3IybhZO2n6TFbHNQbST2oHY4c4axjdstoJaMRC+QJyB+C8/Q7VK5Rs/qZsylk+E9BwPdZ9xR4sAxx0lOCNjYu2PYVpSVBlSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ
Thread-Index:
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYIAABcIAgAAChLCAAHFxgIAAHa6ggABpWICAAHwV4IAACZWAgAAiwLCAAGU9gIAAAqIggADn3oCAAPNNAIAACTvQgABBawCAAhKfIIAAwayAgAAF5ECAAAQjAIAAAcxggAACF4CAAAAyYIAAAZcAgAAARXCAADjCgIAAD1EAgACbcBCAAhV1gIAAG61AgABWJQCAAF7h8IAAeXEAgAAB+uA=
Date: Sun, 11 Jun 2023 20:17:56 +0000
Message-ID:
 <PH0PR12MB54817172C727937B70E2FA3EDC57A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB5481F1BE96B1CE71F4FBD2D8DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu+LDKUkg5ZZjcRsztrL1QGY2a6wto8r93Ddwc6L=a63w@mail.gmail.com>
 <PH0PR12MB5481175A9D915E3BF396AFFBDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsN=5DcMsZa5hHGKb9kCRUVA2CcwZ4uif-E0HKaXiJ-fA@mail.gmail.com>
 <20230609031923-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CE9205B222B57680AE4DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230610202143-mutt-send-email-mst@kernel.org>
 <DM8PR12MB54807B410DCF097D0DC969A1DC57A@DM8PR12MB5480.namprd12.prod.outlook.com>
 <20230611031129-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C7D98AEB2C3328CCF635DC57A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230611160828-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230611160828-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB8122:EE_
x-ms-office365-filtering-correlation-id: 940caebb-ed26-469f-ac03-08db6ab8f200
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 K6vU6+OJ7cw2FUxZLAEgWKaSmZ8kc9qkp4bBTfbdN5Fj9Xqh1WWcpcnTLaVoDtaMd6lJl7M056CXG8xLw5947uNKJlVp3H8vOSOZrJtAN7dUuau3Yjp9+GsBgI5FDn6f0W6wHx4T7FObUxn6nQiAe1Fjq5Q6Qvh2J7ORcR5SlHIjhN8N9wrQrnvoxx7YN8Z4fffBwzscgz2RbVs7LNmlm5YPouZtuNANMLWPV/nIm8oPWypDfVc7ATwOcC1eu4dvGYfsymhvz0mezJ7lj2nbEebp+KKfTRWA0cJDe89toIm/+P+3P2x83Q60/Dpvt1CzqjpbDUWlXP9p2KqIEEcIITSbRnoVkFMHJkbWEH5tCO0Q7yHM8lHps7EPFDHl/OatOvGtAjdkKRDv2uPhiyqwLunOL1Ms9b3JJDcXoy1y6LjI1F9Pou3uhdFs5J4EbEo8HcyubcOgUqcA6v0kadOp0TIkf2SJM3E9e/IHjtrRlVn/lJxUJ5xS6Coa6WARHqhnqh5NZus4O18sC5KhQ0OECF0D7VjebuhYxjpvD2QdopuNXUMGOS/WeSM2VhOPGB5TqSUWgkBRtQ3IaHHkFLGVds0YfVz5JnM9EIplRWOStaW+LLic3mgM1z2S8lOeSUaG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199021)(55016003)(83380400001)(66556008)(66946007)(66446008)(64756008)(6916009)(76116006)(26005)(6506007)(71200400001)(7696005)(107886003)(9686003)(478600001)(54906003)(186003)(86362001)(4744005)(2906002)(8936002)(8676002)(52536014)(5660300002)(33656002)(4326008)(122000001)(41300700001)(38070700005)(38100700002)(316002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IbPanFTkinfgARDEBruCHDx6mCp4EzKDeQXd3GQ6zfS7BOYev0FC1dQ8wipt?=
 =?us-ascii?Q?iEuUKNwp5E+HeYTMJ4nx13lTc4jTRmEK+HMbu6pe1TS7nzU1zILM6/OQ7l5t?=
 =?us-ascii?Q?TiL2hTWsuXCVfr0Oo7+MBr8KL3sRQ+BbVd+/MpRWDyasZn2lQRTCmfFEwIpd?=
 =?us-ascii?Q?RGo5b9HvDjFa/93jAP+T4kyZ01y3+fnHKelZI+EA0xD3I/hH3/15R/OoHMym?=
 =?us-ascii?Q?sCb2WS8lZp7K6VjWg/YfNZIIvKldURDM6edbt7HOzO5ipGERqcssAs8/9YIQ?=
 =?us-ascii?Q?+D6W0nJEsk+jyr8cdnfQln6PFVfrsNpEXLvefpT6cOHDt1MR16f0rKQs/ivh?=
 =?us-ascii?Q?qZUj5kjk4TviOLX+L+paMe/0oLnI2k6hMJPN1yN1e2A6A7dCSIKIkX5GjU+i?=
 =?us-ascii?Q?l9/xOd89chKD0p5uMaCoIevfSCCRxZa0IbYszlfnL1qfC0a/W6jIunWV/kgz?=
 =?us-ascii?Q?vsyCWhgaEHRRMA69FjZfjgjRma0oLqdfSEBMo6dcUiHJ8BwiEu2tXhb6I451?=
 =?us-ascii?Q?2DfsPpbifz9nm7HHQielt3fHTCmcLryqOIY02kr6mF7vioP4Pr6LfPvNfQCo?=
 =?us-ascii?Q?sCTfh5AtUH9lcy0Hbu4o75QuhRvKQKR0pCRC9eXgvhsjfmAWxuVfKh9HXdxI?=
 =?us-ascii?Q?ymuT9+X8pZoTJ9LCvb61O01EYhQ8RkyROq/jfyeZsXGDCxc0rbMV15VlvBjI?=
 =?us-ascii?Q?ailpW/X4/h5qqJZHbOITuaE6AVZksRwbiIPKb+7s1Y/KV9ZxwGLKb7NYdmZH?=
 =?us-ascii?Q?XGXETnYedIUjInbE+hFs5gr8KnSPPO/hPXKtwFITZ+19i3OwXpYemkYHRU6m?=
 =?us-ascii?Q?63T7jmgBuKZ3GeCXGKFq4L9B2X2Jxn+E8Cx29eq3oWGizOr5/FdP8w4vbhsU?=
 =?us-ascii?Q?yO9Rb+4EVkU+nIiVRV31aeny2VSGCq0+6yTOsCdw6SUEP2FEjtp1XdLydeWc?=
 =?us-ascii?Q?mfMoDaQdmKh9UXsGb1IjEKlIr4S0svg9Q985gBwbmsdsukUkoJL0CDNBMkMC?=
 =?us-ascii?Q?0w127IIWIX1PFE+kePIBq1Ao9edOadA2Nu20ZjeKrY6X5gWhdHqlpAO8bw1x?=
 =?us-ascii?Q?pe9ZAXxvgE9gpjjwVxJ4TzugymqlIKMBC9yEYYaBvwCjChANficqWAHhLhlH?=
 =?us-ascii?Q?8lPJAOO47IBIG0XaMrpya7B3EOscW3sDZb4agDsb4b8gbVEcnP2X7XAr7u2n?=
 =?us-ascii?Q?KYCCiPRnmz6eoHEr6iZc37MkNTdgDk+pz51kCYCYmati08kgS1jIxnb5BgXp?=
 =?us-ascii?Q?YDYO81Ig085NZawkNwWsZhC29+Qjf3xGMQ9jh7taJdPuoXgIUlg/StsSkcv/?=
 =?us-ascii?Q?UhyNkKnPrzCZVOU9Yamj7VLTXp9mNFglh/fhkMFzdcidCagJ7izk0+xlLxpu?=
 =?us-ascii?Q?rGD+WE9JUOrDJpGFA5DA5et/wvSrfdSO7VXdxxWjLgCY70nNzfEQj0c9EtXt?=
 =?us-ascii?Q?uvSKxCnnTTFAz/+6DXHQ0jZEmCH/KeKAzwYM2WWbFtGY/q1f5mm8edAWUATc?=
 =?us-ascii?Q?5Mk3/QTsyiO3J1XDxE7nAm72EWG80yxK11ofXGpTt85JMRimVMVbZgWzw0OI?=
 =?us-ascii?Q?K6+d75H4LVytWy9lLko=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940caebb-ed26-469f-ac03-08db6ab8f200
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2023 20:17:56.9363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fmd0VrSvk8iD9LHOhOebe+GuZkMy7Lgb7/sWUFv7+mU5GAG/bv8r6TdiNh7IPaI1ivC8V3KL/ZUckmxR8HWmtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, June 11, 2023 4:09 PM

> > > It's not conformant to that statement then :( It's a SHOULD which
> > > means if you know exactly what you are doing, there could be exceptio=
ns.
> > > In this case it's a SHOULD because it was added after 1.0 and we did
> > > not find a way to negotiate this requirement since it's the feature n=
egotiation
> itself.
> >
> > True. May be in future such device can update the revision id.
>=20
> You can already change it but that doesn't imply anything at all, in 1.0 =
revisions
> are vendor specific.

I was suggesting that when such a fundamental change is done which cannot b=
e communicated via features bit or before the reset,
a new revision and attaching more advance/different behavior.
This way driver knows what difference to expect for new revision.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

