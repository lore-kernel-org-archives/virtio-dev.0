Return-Path: <virtio-dev-return-13280-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776B0EB64DC
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 19:00:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D44F142832
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 19:00:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C6BFD986830
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 19:00:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B509C98680F; Thu,  6 Jul 2023 19:00:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9E71098672E;
	Thu,  6 Jul 2023 19:00:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fj21Kso04LrTIAWJEnPUDeYboHXD/SfOzNYFG5uh5Vn19hZRSB8Nsg7C+nYjoKUxPQG7n36QxPmt7Uq0r0ZiDqzU+j8Ntl+4hBkH1LkEjhBaJjqNXcoMDw7GcRMvxAVPuC91UOf+SI5Ne29aFyQJZgWID64CtDDZ47wKyHs3Q5gjh7LVT0XHkaRM+thNYPNSP/Qju26Esl9kLf36H8m5HwBBkYD+HPUsCbZqus5N65xQLxVy1B7MdPcpSdsHnkQlWyC4LlF7/2cE2KhuQdctoU8spgvl3ZUi+m/uOKaTycRiYd7jeWAjMERkPPp99O+YHmnrnHO+XFTMWJ/vJuw9jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aL8f46ABzKretUIr2yNB6M0XbBAXReDEFxRtdK6ccM=;
 b=EO4dRWKwubQWrvPYOxSeAjbL4TADN3gaETtFJ75qqPZdWPG9IOeVHZ+ePoeU5ff3upitaUKNXBWDD5QblpAwFTDzgnsRuOZbdBrDqhkNeHZXko3x0wnhgULKxB+cSwpfaHctJecxuhh0Ta3Xq+7bnAx2yHuTKO0JICK/jKgXPIZ93Osc6TmG5EYzaxKeBZIW0Ezm3sAd4hvWnWMogzrvHOVn3cJi/Eha+uT10dSMrWgYLOXrw6iynlcmzRD+NOA8lhMZFaFkZApU14tNJpEo1UfHOtD7VVrGknZtzcut+94wsv48HY1974BKO2Oh5spOoxMuaqvepjpMEBxmPRb3XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Cornelia Huck <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access
Thread-Index:
 AQHZr8EFxUk4agfAiUezeNF66UoB2q+s7j+AgAAAMsCAAAOkgIAAA7AwgAAKzQCAAACqYIAACE2AgAAAimCAAAs8AIAAAGiwgAAB8QCAAABNUA==
Date: Thu, 6 Jul 2023 19:00:22 +0000
Message-ID:
 <PH0PR12MB5481074A79C630384382CB20DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <87r0pluhqy.fsf@redhat.com>
 <PH0PR12MB5481ED484C57428AD3D959C5DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706123954-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817D2E9B0D7C5FE9EA2B0EDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706132638-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813564E839C71709DCBDEFDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706135858-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B845ED0FDA919B822941DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706144427-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817A61E0062B9BF3401836DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706145538-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230706145538-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5029:EE_
x-ms-office365-filtering-correlation-id: 071e7d08-7b53-47b4-b94d-08db7e533fff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GnTtJzLeAq1zZeszlqmrT+TOx5xHyNwuxtaDwc9hkkvqscQS48vr9SdY720aQyR2c4QgE4+ZmqxM+Ii5XWyZfEytE+jyodQfd/uY2v2FswOWFSC8Dkx+ZJhrSlK+NJEQyiusKN/bAK/CRG+xB/E0pui+F+B+wDzfn5WLiIS+XGber3gix0AEDHLoRalwpfd00i5aHU8IAP9x9iIGt8dvVS3oe1Tzb3T9q6u/D8yhpOaj69RKQKrHtLTVkElD5TeJZ6W0L6/KDjzaKnNYjlzn0/jRrCMgrfAibXXnsSBJFTKaWhX73rffj7T5RPmth+OBm/jF+GppT+0SPhZM3Ysgoppwjd7+J0lLP+y5JrMWYN91V2PSMpHW4Y4hqgh2/TN251QvvbegH6MPTJnld5YyAXwDUeA+CEWm92yarFdDXi4AWZiinpnEyGuburHqo38T6chfkYG4xcqsemdlgSWxWRGknJFKLOlgsKhOIXpOP3YEidhiQcA14s5pRwqfHoL9spEi9WciAY05ufDeGsTXV0o6sIAm8A+maFoR1NPTuwPH983bDlAy/bGvAfLSRBUxRUgplPCTmZ2wTAjUmuFC4e3NMAFqQYD+mRGp4j87BwsTJ51RIFHBu/wHvG+I67xO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199021)(5660300002)(8936002)(52536014)(8676002)(41300700001)(66556008)(66476007)(76116006)(66946007)(316002)(4326008)(66446008)(64756008)(6916009)(2906002)(54906003)(71200400001)(7696005)(107886003)(9686003)(6506007)(186003)(4744005)(122000001)(83380400001)(478600001)(33656002)(86362001)(38070700005)(38100700002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LE4jm127I1rQGo5pjrGj2wL2KEYPdwZTq7UT560/Ux/nbt3Uu/v5OCaLE1B+?=
 =?us-ascii?Q?59rxk89Q4p+Yi0TOAhSa0koMq15H1pYFoDvScVN2mCqRqYtY31BddTSQjZvz?=
 =?us-ascii?Q?JSDOSxW0+c9VrySygJZjp+/uOFkcSsPjvRL1GQYULBP2beBF8uznx7CDxuiz?=
 =?us-ascii?Q?lokJgY9P+FXIRwpnVXZ0Zpqe+rOpqfoYdSmw12ara8qg5ileSpm53yciUepZ?=
 =?us-ascii?Q?cYiWnufbYRTkAsF8C4bbnFGhRHpc2uxt5sQAJlI/pjr69L6r2Xv67u23WKqH?=
 =?us-ascii?Q?96arqnHX7HcbPKmipuhghfKJ/Wk3vMDCmueT42DGQIY2UegKtafpn414Euwp?=
 =?us-ascii?Q?qd4ZEOyyHCa9FBeJfbSr/rkh8V8i7RgaTa6qzAO0nidRNzZ5xeiRGZowNzlr?=
 =?us-ascii?Q?8IUo+FMlLhKTZsCLQ0UGbitk4jAw48jTT9LdcIC+7ZsVBFEQyuShErjWma77?=
 =?us-ascii?Q?kKll2riQvjM9dPO0JxFGlrmKipyHcrBS9dupgOPZjdQPWHDXFlpAbsJvYKqY?=
 =?us-ascii?Q?MAU3xMxi8WTfXgQIiKsRiUzrZEmulX3HKCebBB1UGrP9bOXV5/FAnJApoBHi?=
 =?us-ascii?Q?Ukz5Es4HtFSuI8k9IkMmQyLf4x2cyEfTNuXKm8ZQxJoTvSpBe2/u1AxkE50x?=
 =?us-ascii?Q?n0MDfk94ULS4yLLQiFH4cY6mvsPmQX1f17KJnYpt9TBwUhszKDp+Iz6b0f4C?=
 =?us-ascii?Q?X63TtVWZKix4zI+fYCqS0JrxLJT9ZNO74CkhZzWGAbrk74DOj5xCp6NvxOxY?=
 =?us-ascii?Q?kLNByVy4hsPdgNBmOVtU6KKroqOVDrbnD4LhWebzhWT47esF9Qn076E9yRmv?=
 =?us-ascii?Q?Sg5EBcC/59QnCUBhRMt8Cveq9DDJSrIX6wyRBMzrzk62ICWwte8ph7hhtr/o?=
 =?us-ascii?Q?a5gTO4+M7xi0Z8vYqgJ9Gbu9QqZBL/hMhZNEKaMJHC1D2tfW6IMdSCHK/Lj1?=
 =?us-ascii?Q?motHvp7GZrVDhYY4LhlR2bhngfej8FOIHfs+EOVqjxnY9XFZZ/EsT3iOIIgF?=
 =?us-ascii?Q?hykMUK3G/kHj0FFlEEZ7L3hWkvINw4IgVmteTmUV0I8fB8K1DqzQ3HLDtm1E?=
 =?us-ascii?Q?xLEugpTQUnoVuDf4rMsOfgdlSGweLM0S5acQcdzEP1uX0I4uUK9EwcQYdHl7?=
 =?us-ascii?Q?bGWbxQj6RLI+XDc9EdLq8EacP6ODaYQ/e4hTQwnaaEt8mro+YhOUk5Be5G/J?=
 =?us-ascii?Q?ZuwPrqO0RRCGih3DgFaTg+iEGRdCAZBKUhmQBsUhm0HKDjFx//UaU/dsND1d?=
 =?us-ascii?Q?pRTcbekHAjGCD9BM6H5F6IDROtqjIX9gZ27+yblOzqxFhH+ECupCrEIz0zys?=
 =?us-ascii?Q?Z3qB+bzKALC7ZOozJlfPY0UykFHIoIFaEfmxIWJI+uqqDV1xrqhWpiHoJrJI?=
 =?us-ascii?Q?wXYecmqDyaf7i5CNDNJATSsO/vtYBfiAY9PMfJux0yqJcGkAIph1dQpsv7zT?=
 =?us-ascii?Q?byVrQH/qIpA+ZnhOu4UXt+4jLI1aMBGkMmvjsUhh1SmvQzQdKJqdQ+mZC6Io?=
 =?us-ascii?Q?E9neUdRuXkWcVBpVkGF8xpOFoHvE1HAw7GSy12KxPHdlH+b5rkFP55Ti6AH2?=
 =?us-ascii?Q?En9qJjZHzxZOxxV5fvgqb4MlxJ9YoZaMWq602rz3JrZx+4LVAVobu8bBFCOo?=
 =?us-ascii?Q?P2xPebbl/YKIWuvmPXTL/hU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071e7d08-7b53-47b4-b94d-08db7e533fff
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 19:00:22.3647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5pj/aC2dHow5hBrfeAk9RC6J4GIocKyg6EfbWMgHZLBhFs+1yyDmV9mxXI8t17CcEf3Ro4aBSUS765EZRgfgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5029
Subject: [virtio-dev] RE: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, July 6, 2023 2:57 PM

> > I am just saying to keep things simple. Let driver choose any entry it =
wants to
> use instead of device deciding on priority and hints etc.
>=20
> Let's say driver can support both types which to choose?
Any entry that driver likes.

> As the order is there anyway, why not just prescribe entries are used in =
order?

I don't see any value in defining any order. It is an array of entries not =
a priority list.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

